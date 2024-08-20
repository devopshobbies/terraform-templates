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


variable "sg_name" {
  description = "Security group name in Arvancloud web console"
  type        = string
}

variable "description" {
  description = "Description for security gorup"
  type        = string
  default     = "Created from Terrafrom"
}

variable "security_group_rules" {
  type = list(object({
    description = string
    direction   = string
    protocol    = string
    port_from   = string
    port_to     = string
    ips         = list(string)
  }))
  default = [
    {
      description = "Default description from terraform"
      direction   = "ingress"
      protocol    = "tcp"
      port_from   = "0"
      port_to     = "1024"
      ips         = []
    }
  ]
  validation {
    # Validation for protocol
    condition = alltrue([
      for rule in var.security_group_rules : contains(
        [
          "tcp",
          "udp"
        ],
        rule.protocol
      )
    ])
    error_message = <<-EOF
		"
		Specify valid protocol name. Using the following available protocols.
		tcp or udp
		"
		EOF
  }

  validation {
    # Validation for direction
    condition = alltrue([
      for rule in var.security_group_rules : contains(
        [
          "ingress",
          "egress"
        ],
        rule.direction
      )
    ])
    error_message = <<-EOF
		"
		Specify valid direction. Use one of the following:
		ingress or egress
		"
		EOF
  }

  validation {
    # Validation for port_from and port_to
    condition = alltrue([
      for rule in var.security_group_rules : (
        tonumber(rule.port_from) >= 0 && tonumber(rule.port_from) <= 65535 &&
        tonumber(rule.port_to) >= 0 && tonumber(rule.port_to) <= 65535
      )
    ])
    error_message = <<-EOF
		"
		Port values must be between 0 and 65535 for both port_from and port_to.
		"
		EOF
  }
}

variable "abrak_uuid" {
  description = "Abrak UUID to attach to security group"
  type        = string
  default     = ""
}

variable "attach_to_abrak" {
  description = "Disable this vairable when you want to dettach from abrak"
  type        = bool
  default     = true
}