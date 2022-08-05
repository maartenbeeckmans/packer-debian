#####################
## Basic variables ##
#####################

# Build vars
name          = "debian-11.4.0"
version       = "1.2"
build_dir     = "./packer_builds"
scripts_dir   = "./scripts"
http_dir      = "./http"
templates_dir = "./templates"
files_dir     = "./files"

# OS vars
iso_checksum = "eeab770236777e588f6ce0f984a7f3e85d86295625010e78a0fca3e873f78188af7966b53319dde3ddcaaaa5d6b9c803e4d80470755e75796fbf0e96c973507f"
iso_name     = "debian-11.4.0-amd64-netinst.iso"
preseed_path = "preseed.cfg"
template     = "debian-11.4.0"
mirror       = "http://cdimage.debian.org/cdimage/release"
mirror_dir   = "11.4.0/amd64/iso-cd"

# VM vars
box_basename = "debian-11.4.0"
cpus         = 2
memory       = 1024
disk_size    = "50G"
headless     = true
