#####################
## Basic variables ##
#####################

# Build vars
name          = "debian-11.2.0"
version       = "1.1"
build_dir     = "./packer_builds"
scripts_dir   = "./scripts"
http_dir      = "./http"
templates_dir = "./templates"
files_dir     = "./files"

# OS vars
iso_checksum = "c685b85cf9f248633ba3cd2b9f9e781fa03225587e0c332aef2063f6877a1f0622f56d44cf0690087b0ca36883147ecb5593e3da6f965968402cdbdf12f6dd74"
iso_name     = "debian-11.2.0-amd64-netinst.iso"
preseed_path = "preseed.cfg"
template     = "debian-11.2.0"
mirror       = "http://cdimage.debian.org/cdimage/release"
mirror_dir   = "11.2.0/amd64/iso-cd"

# VM vars
box_basename = "debian-11.2.0"
cpus         = 2
memory       = 1024
disk_size    = "50G"
headless     = true
