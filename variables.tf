variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true # this will hide the value in the UI
}

variable "region" {
  type = string
  default = "fra1"
}