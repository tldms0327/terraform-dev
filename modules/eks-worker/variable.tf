variable "name" {
  description = "Name of the worker. e.g: worker"
  type        = string
}

variable "subname" {
  description = "Subname of the worker, e.g: a"
  type        = string
  default     = ""
}

variable "vername" {
  description = "Version of the worker, e.g: v1"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name of the cluster."
  type        = string
}

variable "node_role_arn" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "ami_type" {
  type    = string
  default = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
}

variable "instance_types" {
  type    = list(string)
  default = []
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "enable_monitoring" {
  type    = bool
  default = true
}

variable "enable_spot" {
  type    = bool
  default = false
}

variable "enable_taints" {
  type    = bool
  default = false
}

variable "ebs_optimized" {
  type    = bool
  default = true
}

variable "volume_type" {
  type    = string
  default = "gp2"
}

variable "volume_size" {
  type    = string
  default = "50"
}

variable "min" {
  type    = number
  default = 1
}

variable "max" {
  type    = number
  default = 5
}

variable "max_unavailable_percentage" {
  type    = number
  default = 20
}

variable "key_name" {
  type    = string
  default = "eks_user"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "node_labels" {
  type    = map(string)
  default = {}
}
