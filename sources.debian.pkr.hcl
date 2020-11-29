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
