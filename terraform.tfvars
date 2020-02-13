aws_region   = "us-east-1"

project_name = "elastic-wordpress"

vpc_cidr     = "10.0.0.0/16"

DMZPublic_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

AppLayerPrivate_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

DBLayerPrivate_cidrs = [
  "10.0.5.0/24",
  "10.0.6.0/24"
]

accessip = "0.0.0.0/0"