#---Networking Outputs -----

output "DMZPublicSubnets" {
  value = "${join(", ", module.networking.DMZPublic_subnets)}"
}

output "DMZPublicSubnetIPs" {
  value = "${join(", ", module.networking.DMZPublic_subnet_ips)}"
}

output "AppLayerPrivateSubnets" {
  value = "${join(", ", module.networking.AppLayerPrivate_subnets)}"
}

output "AppLayerPrivateSubnetIPs" {
  value = "${join(", ", module.networking.AppLayerPrivate_subnet_ips)}"
}

output "DBLayerPrivateSubnets" {
  value = "${join(", ", module.networking.DBLayerPrivate_subnets)}"
}

output "DBLayerPrivateSubnetIPs" {
  value = "${join(", ", module.networking.DBLayerPrivate_subnet_ips)}"
}