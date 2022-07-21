variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}
variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "image_id" {
  description = "Disk image"
}
variable "network_id" {
  description = "Network id"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "service_account_key_file" {
  description = "key .json"
}
variable "service_account_id" {
  description = "Service account ID"
}
variable "node_service_account_id" {
  description = "Node service account ID"
}
#---
variable "zone_kube_cluster" {
  description = "Zone kube"
  default     = "ru-central1-a"
}
