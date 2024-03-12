// Define a resource of type 'aws_dynamodb_table'

//- DynamoDB (for course progress tracking)
resource "aws_dynamodb_table" "oln-dynamodb" {
  name           = "oln-dynamodb"    
  read_capacity  = 20   
  write_capacity = 20   
  hash_key       = "Id" 


  attribute {
    name = "Id"
    type = "N"
  }


  server_side_encryption {
    enabled = true
  }
}
