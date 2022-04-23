variable "ami_image" {
  type    = string
  default = "ami-0fb653ca2d3203ac1"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "apache-tomcat-practice"
}