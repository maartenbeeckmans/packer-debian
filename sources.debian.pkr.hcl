#############
## Sources ##
#############
source "qemu" "debian" {
  boot_command = [
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
    "/install.amd/vmlinuz auto=true priority=critical vga=788 initrd=/install.amd/gtk/initrd.gz console=ttyS0,115200 --- quiet ",
    "ipv6.disable_ipv6=1 preseed/url=http://{{.HTTPIP}}:{{.HTTPPort}}/preseed.cfg",
    "<enter>"
  ]
  boot_wait        = "10s"
  cpus             = "${var.cpus}"
  memory           = "${var.memory}"
  disk_size        = "${var.disk_size}"
  headless         = "${var.headless}"
  http_directory   = "./http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  output_directory = "./packer_builds"
  shutdown_command = "sudo -S /sbin/shutdown -hP now"
  ssh_port         = 22
  ssh_timeout      = "3600s"
  ssh_username     = "root"
  ssh_password     = "secret"
  vm_name          = "${local.image_full_name}"
  accelerator      = "kvm"
  format           = "${var.image_format}"
}
