#####################
## Basic variables ##
#####################

# Build vars
name          = "debian-10.9"
version       = "0.3"
build_dir     = "./packer_builds"
scripts_dir   = "./scripts"
http_dir      = "./http"
templates_dir = "./templates"
files_dir     = "./files"

# OS vars
iso_checksum  = "8660593d10de0ce7577c9de4dab886ff540bc9843659c8879d8eea0ab224c109"
iso_name      = "debian-10.9.0-amd64-netinst.iso"
preseed_path  = "preseed.cfg"
template      = "debian-10.9-amd64"
mirror        = "http://cdimage.debian.org/cdimage/release"
mirror_dir    = "10.9.0/amd64/iso-cd"

# VM vars
box_basename = "debian-10.9"
cpus         = 2
memory       = 1024
disk_size    = "10G"
headless     = true
