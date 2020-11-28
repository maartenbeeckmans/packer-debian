###############
## Variables ##
###############
variable "box_basename" {
  type = string
}
variable "build_dir" {
  type = string
}
variable "scripts_dir" {
  type = string
}
variable "cpus" {
  type = number
}
variable "disk_size" {
  type = string
}
variable "headless" {
  type = bool
}
variable "http_dir" {
  type = string
}
variable "iso_checksum" {
  type = string
}
variable "iso_name" {
  type = string
}
variable "memory" {
  type = number
}
variable "mirror" {
  type = string
}
variable "mirror_dir" {
  type = string
}
variable "templates_dir" {
  type = string
}
variable "name" {
  type = string
}
variable "preseed_path" {
  type = string
}
variable "template" {
  type = string
}
variable "version" {
  type = string
}

#############
## Sources ##
#############
source "qemu" "debian10" {
  boot_command     = [
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "<esc><wait><esc><wait><esc><wait><esc><wait><esc><wait><esc><wait>",
    "/install.amd/vmlinuz auto=true priority=critical vga=788 initrd=/install.amd/gtk/initrd.gz --- quiet ",
    "ipv6.disable_ipv6=1 net.ifnames=0 biosdevname=0 preseed/url=http://{{.HTTPIP}}:{{.HTTPPort}}/${var.preseed_path} ",
    "<enter>"
  ]
  boot_wait        = "10s"
  cpus             = "${var.cpus}"
  disk_size        = "${var.disk_size}"
  headless         = "${var.headless}"
  http_directory   = "${var.http_dir}"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.mirror}/${var.mirror_dir}/${var.iso_name}"
  memory           = "${var.memory}"
  output_directory = "${var.build_dir}/packer-${var.template}-qemu"
  shutdown_command = "echo 'vagrant' | sudo -S /sbin/shutdown -hP now"
  ssh_port         = 22
  ssh_timeout      = "3600s"
  ssh_username     = "root"
  ssh_password     = "secret"
  vm_name          = "${var.template}"
  accelerator      = "kvm"
}

###########
## Build ##
###########
build {
  sources = ["source.qemu.debian10"]
  provisioner "shell" {
    environment_vars    = ["HOME_DIR=/root",]
    start_retry_timeout = "15m"
    expect_disconnect   = true
    scripts             = [
      "${var.scripts_dir}/apt.sh",
      "${var.scripts_dir}/network.sh",
    ]
  }
  provisioner "shell" {
    environment_vars    = ["HOME_DIR=/root",]
    expect_disconnect   = true
    start_retry_timeout = "15m"
    pause_before = "120s"
    scripts             = [
      "${var.scripts_dir}/floppy.sh",
      "${var.scripts_dir}/profile.sh",
      "${var.scripts_dir}/vagrant.sh",
      "${var.scripts_dir}/motd.sh",
      "${var.scripts_dir}/fixtty.sh",
      "${var.scripts_dir}/qemu.sh"
    ]
  }
  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    vagrantfile_template = "${var.templates_dir}/debian10.rb"
    output               = "builds/debian10.box"
    include              = [
      "${var.templates_dir}/info.json"
    ]
  }
  post-processor "checksum" {
    checksum_types      = [
      "sha256"
    ]
    keep_input_artifact = false
    output              = "builds/debian10.box.sha256"
  }
}
