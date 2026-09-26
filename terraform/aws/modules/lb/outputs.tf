output "dns_name" {
  description = "DNS público do ALB"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN do target group das instâncias web"
  value       = aws_lb_target_group.web.arn
}

output "security_group_id" {
  description = "Security group do ALB (origem liberada nas instâncias)"
  value       = aws_security_group.alb.id
}
