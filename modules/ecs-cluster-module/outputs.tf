output "ecs-alb-listener-arn" {
  value = aws_alb_listener.ecs-alb-http-listener.arn
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

// Target group arn
output "ecs-tg-arn" {
  value = aws_alb_target_group.ecs-tg.arn
}

// cluster id
output "ecs-cluster-id" {
  value = aws_ecs_cluster.ecs-fargate-cluster.id
}

output "ecs-tg-name" {
  value = aws_alb_target_group.ecs-tg.name
}