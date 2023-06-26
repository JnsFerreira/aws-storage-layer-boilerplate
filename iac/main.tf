locals {
  policy        = file("iac/iam/policies/${var.environment}/policy.json")
  attach_policy = local.policy != "" ? true : false
}

module "storage_layer" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket                                 = var.bucket
  control_object_ownership               = var.control_object_ownership
  object_ownership                       = var.object_ownership
  attach_policy                          = local.attach_policy
  policy                                 = local.policy
  attach_deny_unencrypted_object_uploads = var.deny_unencrypted_object_uploads
  tags                                   = var.tags
}
