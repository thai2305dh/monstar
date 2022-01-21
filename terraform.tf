# terraform {
#   backend "s3" {
#     bucket = "terraform-state-thai"
#     key    = "path/to/my/key"
#     region = "us-east-2"
#     dyamondb_table = "terraform-state-locking"
#     encrypt = true
#   }
# }