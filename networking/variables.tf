variable "vpc_cidr" {}

variable "DMZPublic_cidrs" {
  type = list
}

variable "AppLayerPrivate_cidrs" {
  type = list
}

variable "DBLayerPrivate_cidrs" {
  type = list
}
variable "accessip" {}