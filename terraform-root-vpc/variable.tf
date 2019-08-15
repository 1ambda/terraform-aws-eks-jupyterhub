variable "region" {
  default = "ap-northeast-2"
}

variable "availability_zones" {
  type = "list"
  default = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c",
  ]
}

variable "availability_zone_a" {
  default = "ap-northeast-2a"
}

variable "availability_zone_b" {
  default = "ap-northeast-2b"
}

variable "availability_zone_c" {
  default = "ap-northeast-2c"
}
