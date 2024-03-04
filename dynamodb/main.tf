// Define a resource of type 'aws_dynamodb_table'
resource "aws_dynamodb_table" "oln-dynamodb" {
  name           = "oln-dynamodb"    // Name of the table
  read_capacity  = 20   // The maximum amount of read units
  write_capacity = 20   // The maximum amount of write units
  hash_key       = "Id" // The attribute to use as the hash (partition) key

  // Define the attribute definitions
  attribute {
    name = "Id"
    type = "N"
  }

  // Data will be encrypted at rest using the AWS owned CMK for DynamoDB.
  server_side_encryption {
    enabled = true
  }
}
