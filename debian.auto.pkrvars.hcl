#####################
## Basic variables ##
#####################

# Build vars
name                = "debian-10.6"
version             = "0.1"
build_directory     = "./builds"
scripts_dir         = "./scripts"
http_directory      = "./http"
templates_directory = "./http"

# OS vars
iso_checksum        = "2af8f43d4a7ab852151a7f630ba596572213e17d3579400b5648eba4cc974ed0"
iso_name            = "debian-10.6.0-amd64-netinst.iso"
preseed_path        = "preseed.cfg"
template            = "debian-10.6-amd64"
mirror              = "http://cdimage.debian.org/cdimage/release"
mirror_directory    = "10.6.0/amd64/iso-cd"

# VM vars
box_basename        = "debian-10.6"
cpus                = 2
memory              = 1024
disk_size           = "20G"
headless            = true
