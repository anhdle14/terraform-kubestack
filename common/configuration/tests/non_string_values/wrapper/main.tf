terraform {
  required_version = ">= 1.3.0"
}

variable "test_configuration" {
  type = map(object({
    test_string      = optional(string)
    test_list_string = optional(list(string))
    test_map_string  = optional(map(string))
    test_list_object = optional(list(object({
      key = string
    })))
    test_object = optional(object({
      key = string
    }))
  }))
  description = "Map with per workspace module configuration."
  default = {
    apps = {
      test_string = "from_apps"

      test_list_string = [
        "from_apps"
      ]

      test_map_string = {
        key = "from_apps"
      }

      test_list_object = [{
        key = "from_apps"
      }]

      test_object = {
        key = "from_apps"
      }
    }

    ops = {
      test_string = "from_ops"

      test_list_string = [
        "from_ops"
      ]

      test_map_string = {
        key = "from_ops"
      }

      test_list_object = [{
        key = "from_ops"
      }]

      test_object = {
        key = "from_ops"
      }
    }

    loc = {
      test_list_object = [{
        key = "from_loc"
      }]
    }
  }
}

module "mut_object" {
  source = "../../.."

  configuration = var.test_configuration

  base_key = "apps"
}

output "merged" {
  value = module.mut_object.merged
}
