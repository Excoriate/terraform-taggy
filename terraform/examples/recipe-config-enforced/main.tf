module "recipe_implementation" {
  source = "../../taggy/aws"
  tags   = {
    custom = "mycustomtag"
  }

  // Config required, to trigger the enforcement validations
  config = {
    force_lower_case = false
    force_upper_case = false
    fail_on_enforced_tags_default = false
    fail_on_enforced_tags = true // Set in true.
    enforced_tags_custom_keys = ["mytag", "thisothertag"]
    enforced_tags_convention_doc_ref = "https://example.com"
  }

  // Custom enforced tags
  enforced_tags_custom = {
    mytag = "myvalue"
    thisothertag = "thisothervalue"
  }
}
