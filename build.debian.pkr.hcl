###########
## Build ##
###########
build {
  sources = ["source.qemu.debian11"]
  provisioner "shell" {
    environment_vars    = ["HOME_DIR=/root",]
    start_retry_timeout = "15m"
    expect_disconnect   = true
    scripts             = [
      "${var.scripts_dir}/apt.sh",
      "${var.scripts_dir}/lvm.sh",
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
      "${var.scripts_dir}/motd.sh",
      "${var.scripts_dir}/profile.sh",
      "${var.scripts_dir}/qemu.sh",
      "${var.scripts_dir}/puppet.sh",
      "${var.scripts_dir}/cloud-init.sh"
    ]
  }
  post-processor "checksum" {
    checksum_types      = [
      "sha256"
    ]
    keep_input_artifact = false
    output              = "${var.build_dir}/${var.box_basename}.qcow2.sha256"
  }
  post-processor "compress" {
    output = "${var.build_dir}/${var.box_basename}.qcow2.tar.gz"
    compression_level = 9
  }
}
