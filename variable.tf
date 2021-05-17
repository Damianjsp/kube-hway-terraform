variable "location" {
  default = "East US"
}

variable "tag" {
    type = map
    default = {
      environment = "hardway"
      }
}

variable "name" {
    default = "hway"
}

variable "contname" {
	 default = "control"
	
}

variable "contsize" {
	 default = "Standard_D2a_V4"
	
}

variable "workname" {
	 default = "work"
	
}

variable "worksize" {
	 default = "Standard_D2a_V4"
	
}