variable "aws_region" {}

variable "project_name" {}


variable "vpc_cidr" {}

variable "DMZPublic_cidrs" {
  type = list(string)
}

variable "AppLayerPrivate_cidrs" {
  type = list(string)
}

variable "DBLayerPrivate_cidrs" {
  type = list(string)
}

variable "accessip" {}