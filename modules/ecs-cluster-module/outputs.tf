output "ecs-alb-listener-arn" {
  value = aws_lb_listener.ecs-listener.arn
}

output "ecs-cluster-name" {
  value = aws_ecs_cluster.ecs-fargate-cluster.name
}
output "ecs-cluster-arn" {
  value = aws_ecs_cluster.ecs-fargate-cluster.arn
}

output "ecs-cluster-role-name" {
  value = aws_iam_role.ecs-role.name
}
