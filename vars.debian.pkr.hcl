###############
## Variables ##
###############
variable "box_basename" {
  type = string
}
variable "build_dir" {
  type = string
}
variable "scripts_dir" {
  type = string
}
variable "cpus" {
  type = number
}
variable "disk_size" {
  type = string
}
variable "headless" {
  type = bool
}
variable "http_dir" {
  type = string
}
variable "iso_checksum" {
  type = string
}
variable "iso_name" {
  type = string
}
variable "memory" {
  type = number
}
variable "mirror" {
  type = string
}
variable "mirror_dir" {
  type = string
}
variable "templates_dir" {
  type = string
}
variable "files_dir" {
  type = string
}
variable "name" {
  type = string
}
variable "preseed_path" {
  type = string
}
variable "template" {
  type = string
}
variable "version" {
  type = string
}
