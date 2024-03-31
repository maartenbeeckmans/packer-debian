variable "image_name" {
  type = string
}

variable "image_version" {
  type = string
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

variable "proxmox_node" {
  type = string
}

variable "proxmox_url" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_password" {
  type = string
}

locals {
  image_full_name = "${var.image_name}-${var.image_version}"
}

source "proxmox-iso" "debian" {
  iso_checksum = "${var.iso_checksum}"
  iso_url      = "${var.iso_url}"
  iso_storage_pool = "local"
  unmount_iso  = true

  proxmox_url              = "${var.proxmox_url}"
  insecure_skip_tls_verify = true
  username                 = "${var.proxmox_username}"
  password                 = "${var.proxmox_password}"

  node = "${var.proxmox_node}"
  tags = "packer,${var.image_name}"

  cores   = "${var.cpus}"
  memory  = "${var.memory}"
  os      = "l26"
  machine = "q35"

  disks {
    disk_size    = "${var.disk_size}"
    storage_pool = "local-lvm"
    type         = "virtio"
  }

  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }

  ssh_timeout  = "3600s"
  ssh_username = "root"
  ssh_password = "secret"

  vm_id                = "1001"
  template_description = "${local.image_full_name}, generated on ${timestamp()}"
  template_name        = "${local.image_full_name}"

  
  boot_command = [
    "<up><tab> priority=critical auto=true preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"
  ]
  boot_wait      = "10s"
  http_directory = "./http"
}

build {
  sources = [
    "source.proxmox-iso.debian"
  ]
  provisioner "ansible" {
    playbook_file   = "provisioning/playbook.yml"
    extra_arguments = ["--scp-extra-args", "'-O'", "--skip-tags", "systemd_resolved"]
  }
}