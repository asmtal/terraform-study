
variable "access_key" {}
variable "secret_key" {}

variable "name" {
    default = "exercise"
}

variable "region" {
    default = "ap-northeast-1"
}

variable "cidr" {
    type = "map"

    default = {
        vpc = "10.0.0.0/8"
    }
}

variable "env" {
    type = "map"

    default = {
        prd = 0
        stg = 1
    }
}

variable "newbit" {
    default = "8"
}

variable "vpc_number" {
    type = "map"

    default = {
        us-east-1      =  1 # US East (N. Virginia)
        us-east-2      =  2 # US East (Ohio)
        us-west-1      =  3 # US West (N. California)
        us-west-2      =  4 # US West (Oregon)
        ca-central-1   =  5 # Canada (Central)
        eu-west-1      =  6 # EU (Ireland)
        eu-central-1   =  7 # EU (Frankfurt)
        eu-west-2      =  8 # EU (London)
        ap-northeast-1 =  9 # Asia Pacific (Tokyo)
        ap-northeast-2 = 10 # Asia Pacific (Seoul)
        ap-southeast-1 = 11 # Asia Pacific (Singapore)
        ap-southeast-2 = 12 # Asia Pacific (Sydney)
        ap-south-1     = 13 # Asia Pacific (Mumbai)
        sa-east-1      = 14 # South America (São Paulo)
    }
}

