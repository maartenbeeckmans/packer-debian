#####################
## Basic variables ##
#####################

# Build vars
name          = "debian-11.1.0"
version       = "0.2"
build_dir     = "./packer_builds"
scripts_dir   = "./scripts"
http_dir      = "./http"
templates_dir = "./templates"
files_dir     = "./files"

# OS vars
iso_checksum  = "02257c3ec27e45d9f022c181a69b59da67e5c72871cdb4f9a69db323a1fad58093f2e69702d29aa98f5f65e920e0b970d816475a5a936e1f3bf33832257b7e92"
iso_name      = "debian-11.1.0-amd64-netinst.iso"
preseed_path  = "preseed.cfg"
template      = "debian-11.1.0"
mirror        = "http://cdimage.debian.org/cdimage/release"
mirror_dir    = "11.1.0/amd64/iso-cd"

# VM vars
box_basename = "debian-11.1.0"
cpus         = 2
memory       = 1024
disk_size    = "50G"
headless     = true
