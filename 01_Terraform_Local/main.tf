terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

resource "local_file" "demo" {
  content  = "NARENDRA BABU"
  filename = "sample.txt"
  file_permission = "777"
}