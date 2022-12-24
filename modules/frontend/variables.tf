variable "project" {
  description = "Name Project"
}
variable "stage" {
  description = "Stage"
  default     = "production"
}
variable "group" {
  description = "Type microservice"
  default     = "backend"
}
variable "type" {
  description = "Resource Type"
  default     = "cluster"
}
variable "monitoring" {
  default = "enabled"
}
variable "region" {
  description = "Region to Deploy"
}
variable "bucket-name" {
  description = "Name of bucket CDN"
}
variable "certificate_arn_frontend" {
  description = "SSL Wildcard"
}
variable "dns_alb" {
  description = "Redirect Default Behaviour to ALB"
}