variable "user_uuid" {
  type    = string
  description = "User UUID in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
  }
}
