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
      "${var.scripts_dir}/motd.sh",
      "${var.scripts_dir}/vagrant.sh",
      "${var.scripts_dir}/profile.sh",
      "${var.scripts_dir}/qemu.sh",
      "${var.scripts_dir}/puppet.sh"
    ]
  }
  post-processor "vagrant" {
    compression_level    = 9
    keep_input_artifact  = false
    vagrantfile_template = "${var.templates_dir}/debian10.rb"
    output               = "${var.build_dir}/debian10.box"
    include              = [
      "${var.templates_dir}/info.json"
    ]
  }
  post-processor "checksum" {
    checksum_types      = [
      "sha256"
    ]
    keep_input_artifact = false
    output              = "${var.build_dir}/debian10.box.sha256"
  }
}
