#####################
## Basic variables ##
#####################

# Build vars
name          = "debian-11.0.0"
version       = "0.1"
build_dir     = "./packer_builds"
scripts_dir   = "./scripts"
http_dir      = "./http"
templates_dir = "./templates"
files_dir     = "./files"

# OS vars
iso_checksum  = "5f6aed67b159d7ccc1a90df33cc8a314aa278728a6f50707ebf10c02e46664e383ca5fa19163b0a1c6a4cb77a39587881584b00b45f512b4a470f1138eaa1801"
iso_name      = "debian-11.0.0-amd64-netinst.iso"
preseed_path  = "preseed.cfg"
template      = "debian-11.0.0"
mirror        = "http://cdimage.debian.org/cdimage/release"
mirror_dir    = "11.0.0/amd64/iso-cd"

# VM vars
box_basename = "debian-11.0.0"
cpus         = 2
memory       = 1024
disk_size    = "50G"
headless     = true
