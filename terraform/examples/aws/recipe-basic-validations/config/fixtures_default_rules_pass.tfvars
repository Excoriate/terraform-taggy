is_enabled = true

tags = {
  "application" = "terratest"
  "environment" = "test"
  "aws:invalid" = "invalid" // This invalid will make this test to fail, expected assertion. ;)
}
