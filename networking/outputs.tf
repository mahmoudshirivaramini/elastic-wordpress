output "DMZPublic_subnets" {
  value = aws_subnet.ewp_DMZPublic_subnet.*.id
}

output "DMZPublic_subnet_ips" {
  value = aws_subnet.ewp_DMZPublic_subnet.*.cidr_block
}

output "AppLayerPrivate_subnets" {
  value = aws_subnet.ewp_AppLayerPrivate_subnet.*.id
}

output "AppLayerPrivate_subnet_ips" {
  value = aws_subnet.ewp_AppLayerPrivate_subnet.*.cidr_block
}

output "DBLayerPrivate_subnets" {
  value = aws_subnet.ewp_AppLayerPrivate_subnet.*.id
}

output "DBLayerPrivate_subnet_ips" {
  value = aws_subnet.ewp_AppLayerPrivate_subnet.*.cidr_block
}