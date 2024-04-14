// Access load balancer DNS
output "lb_dns" {
    value = aws_lb.load-balancer.dns_name
}