variable prefix {
    description = "prefix to add to the resources generated by this terraform project"
    type = string
}

variable name {
    description = "Name to identify the resources. Each name will create a different set of user-group-policy-role"
    type = string
}

variable account {
    description = "Account where the role will allow to be assumed"
    type = string
}

variable toggle_suffix {
    description = "Decides if toggle the suffix with the resource type"
    type = bool
}