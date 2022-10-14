###########
## Build ##
###########
build {
  sources = ["source.qemu.debian"]
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
      "./scripts/floppy.sh",
      "./scripts/motd.sh",
      "./scripts/profile.sh",
      "./scripts/qemu.sh",
      "./scripts/puppet.sh",
      "./scripts/cloud-init.sh"
    ]
  }
  post-processor "checksum" {
    checksum_types = [
      "sha256"
    ]
    keep_input_artifact = false
    output              = "./packer_builds/debian10.box.sha256"
  }
  post-processor "compress" {
    output            = "./packer_builds/debian10.qcow2.tar.gz"
    compression_level = 9
  }
}
