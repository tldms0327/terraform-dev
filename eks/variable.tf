variable "region" {
  description = "리전을 입력 합니다. e.g: ap-northeast-2"
  default     = "ap-northeast-2"
}

variable "cluster_name" {
  description = "EKS 클러스터 이름을 입력합니다."
  default     = "eks-dev" # for eks-demo
}

variable "kubernetes_version" {
  description = "쿠버네티스 버전을 입력합니다."
  default     = "1.22"
}

variable "key_name" {
  default = "karin_cb"
}
