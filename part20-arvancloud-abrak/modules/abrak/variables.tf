variable "region" {
  description = "Arvancloud region name."
  type        = string
  validation {
    condition = contains(
      [
        "ir-thr-c2",  # Forogh
        "ir-tbz-dc1", # Shahriar
        "ir-thr-w1",  # Bamdad
        "ir-thr-c1"   # Simin
      ],
      var.region
    )
    error_message = <<-EOF
		"
		Specify valid region name. Using the following available regions.
		Forogh ==> ir-thr-c2
		Shahriar ==> ir-tbz-dc1
		Bamdad ==> ir-thr-w1
		Simin ==> ir-thr-c1
		"
		EOF
  }
}

variable "abrak_name" {
  description = "Abrak name in Arvancloud web console"
  type        = string
}

variable "abrak_flavor" {
  description = "Abrak plan ID, you can get list of plan IDs of each region from sizes api"
  # Check "https://napi.arvancloud.ir/ecc/v1/regions/<region>/sizes" to find best falavor size.
  type = string
}

variable "abrak_disk_size" {
  description = "Abrak disk size in GB"
  type        = number
}

variable "abrak_ha_enabled" {
  description = "HA feature in abrak. This feature is exprimental, May not works now."
  type        = bool
  default     = false
}

variable "abrak_image" {
  description = "Abrak image type and name"
  type = object({
    type = string
    name = string
  })
}

variable "abrak_sshkey_enabled" {
  description = "Enabled Arvan ssh public key"
  type        = bool
  default     = false
}

variable "abrak_sshkey_name" {
  description = "Arvan ssh public key name"
  type        = string
  default     = "devopshobies"
}