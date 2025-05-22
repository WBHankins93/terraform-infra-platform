variable "name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "default"
}

variable "service_account" {
  type = string
}

variable "secret_arns" {
  type = list(string)
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}
