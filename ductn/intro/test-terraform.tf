variable "myVar" {
  type = string
  default = "Hello World"
}

variable "myMap" {
  type = map(string)
  default = {
	  key = "value",
	  key1 = "value1"
  }
}

variable "myList" {
  type = list(string)
  default = [1, 2, 3, "abc"]
}
