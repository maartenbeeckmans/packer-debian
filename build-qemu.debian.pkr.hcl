variable "image_name" {
  type = string
}

variable "image_version" {
  type = string
}

variable "image_format" {
  type    = string
  default = "qcow2"
}

variable "cpus" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 1024
}

variable "disk_size" {
  type    = string
  default = "50G"
}

variable "headless" {
  type    = bool
  default = true
}

variable "iso_checksum" {
  type = string
}

variable "iso_url" {
  type = string
}

locals {
  image_full_name = "${var.image_name}-${var.image_version}.${var.image_format}"
}

source "qemu" "debian" {
  boot_command = [
    "e<down><down><down><end>priority=critical auto=true preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed-qemu.cfg<leftCtrlOn>x<leftCtrlOff>"
  ]
  boot_wait         = "10s"
  cpus              = "${var.cpus}"
  memory            = "${var.memory}"
  disk_size         = "${var.disk_size}"
  headless          = "${var.headless}"
  http_directory    = "./http"
  iso_checksum      = "${var.iso_checksum}"
  iso_url           = "${var.iso_url}"
  output_directory  = "./packer_builds"
  shutdown_command  = "sudo -S /sbin/shutdown -hP now"
  ssh_port          = 22
  ssh_timeout       = "3600s"
  ssh_username      = "root"
  ssh_password      = "secret"
  vm_name           = "${local.image_full_name}"
  accelerator       = "kvm"
  format            = "${var.image_format}"
  efi_boot          = true
  efi_firmware_code = "/usr/share/OVMF/x64/OVMF_CODE.fd"
  efi_firmware_vars = "/usr/share/OVMF/x64/OVMF_VARS.fd"
}

build {
  sources = [
    "source.qemu.debian"
  ]
  provisioner "shell" {
    environment_vars    = ["HOME_DIR=/root", ]
    start_retry_timeout = "15m"
    expect_disconnect   = true
    scripts = [
      "./scripts/apt.sh",
      "./scripts/lvm.sh",
      "./scripts/network.sh",
    ]
  }
  provisioner "shell" {
    environment_vars    = ["HOME_DIR=/root", ]
    expect_disconnect   = true
    start_retry_timeout = "15m"
    pause_before        = "120s"
    scripts = [
      "./scripts/efistub.sh",
    ]
  }
  provisioner "shell" {
    environment_vars    = ["HOME_DIR=/root", ]
    expect_disconnect   = true
    start_retry_timeout = "15m"
    pause_before        = "120s"
    scripts = [
      "./scripts/floppy.sh",
      "./scripts/motd.sh",
      "./scripts/profile.sh",
      "./scripts/qemu.sh",
      "./scripts/cloud-init.sh"
    ]
  }
  post-processor "checksum" {
    checksum_types = [
      "sha256"
    ]
    keep_input_artifact = false
    output              = "./packer_builds/${local.image_full_name}.sha256"
  }
  post-processor "compress" {
    compression_level = 9
    output            = "./packer_builds/${local.image_full_name}.tar.gz"
  }
}