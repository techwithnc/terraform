// module for s3 bucket
resource "aws_s3_bucket" "s3bkt" {
  count = length(var.BUCKET_NAME)
  bucket = "${var.BUCKET_NAME[count.index]}"
}
resource "aws_s3_bucket_acl" "s3bkt_acl" {
  count = "3"
  bucket = "${var.BUCKET_NAME[count.index]}"
  acl = "private"
}
resource "aws_s3_bucket_acl" "s3bkt_acl01" {
  bucket = "${var.BUCKET_NAME[3]}"
  acl = "public-read"
}
