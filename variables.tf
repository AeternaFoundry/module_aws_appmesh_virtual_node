variable "appmesh_virtual_nodes" {
  description = <<EOT
Map of appmesh_virtual_nodes, attributes below
Required:
    - mesh_name
    - name
    - spec (block):
        - backend (optional, block):
            - virtual_service (required, block):
                - client_policy (optional, block):
                    - tls (optional, block):
                        - certificate (optional, block):
                            - file (optional, block):
                                - certificate_chain (required)
                                - private_key (required)
                            - sds (optional, block):
                                - secret_name (required)
                        - enforce (optional)
                        - ports (optional)
                        - validation (required, block):
                            - subject_alternative_names (optional, block):
                                - match (required, block):
                                    - exact (required)
                            - trust (required, block):
                                - acm (optional, block):
                                    - certificate_authority_arns (required)
                                - file (optional, block):
                                    - certificate_chain (required)
                                - sds (optional, block):
                                    - secret_name (required)
                - virtual_service_name (required)
        - backend_defaults (optional, block):
            - client_policy (optional, block):
                - tls (optional, block):
                    - certificate (optional, block):
                        - file (optional, block):
                            - certificate_chain (required)
                            - private_key (required)
                        - sds (optional, block):
                            - secret_name (required)
                    - enforce (optional)
                    - ports (optional)
                    - validation (required, block):
                        - subject_alternative_names (optional, block):
                            - match (required, block):
                                - exact (required)
                        - trust (required, block):
                            - acm (optional, block):
                                - certificate_authority_arns (required)
                            - file (optional, block):
                                - certificate_chain (required)
                            - sds (optional, block):
                                - secret_name (required)
        - listener (optional, block):
            - connection_pool (optional, block):
                - grpc (optional, block):
                    - max_requests (required)
                - http (optional, block):
                    - max_connections (required)
                    - max_pending_requests (optional)
                - http2 (optional, block):
                    - max_requests (required)
                - tcp (optional, block):
                    - max_connections (required)
            - health_check (optional, block):
                - healthy_threshold (required)
                - interval_millis (required)
                - path (optional)
                - port (optional)
                - protocol (required)
                - timeout_millis (required)
                - unhealthy_threshold (required)
            - outlier_detection (optional, block):
                - base_ejection_duration (required, block):
                    - unit (required)
                    - value (required)
                - interval (required, block):
                    - unit (required)
                    - value (required)
                - max_ejection_percent (required)
                - max_server_errors (required)
            - port_mapping (required, block):
                - port (required)
                - protocol (required)
            - timeout (optional, block):
                - grpc (optional, block):
                    - idle (optional, block):
                        - unit (required)
                        - value (required)
                    - per_request (optional, block):
                        - unit (required)
                        - value (required)
                - http (optional, block):
                    - idle (optional, block):
                        - unit (required)
                        - value (required)
                    - per_request (optional, block):
                        - unit (required)
                        - value (required)
                - http2 (optional, block):
                    - idle (optional, block):
                        - unit (required)
                        - value (required)
                    - per_request (optional, block):
                        - unit (required)
                        - value (required)
                - tcp (optional, block):
                    - idle (optional, block):
                        - unit (required)
                        - value (required)
            - tls (optional, block):
                - certificate (required, block):
                    - acm (optional, block):
                        - certificate_arn (required)
                    - file (optional, block):
                        - certificate_chain (required)
                        - private_key (required)
                    - sds (optional, block):
                        - secret_name (required)
                - mode (required)
                - validation (optional, block):
                    - subject_alternative_names (optional, block):
                        - match (required, block):
                            - exact (required)
                    - trust (required, block):
                        - file (optional, block):
                            - certificate_chain (required)
                        - sds (optional, block):
                            - secret_name (required)
        - logging (optional, block):
            - access_log (optional, block):
                - file (optional, block):
                    - format (optional, block):
                        - json (optional, block):
                            - key (required)
                            - value (required)
                        - text (optional)
                    - path (required)
        - service_discovery (optional, block):
            - aws_cloud_map (optional, block):
                - attributes (optional)
                - namespace_name (required)
                - service_name (required)
            - dns (optional, block):
                - hostname (required)
                - ip_preference (optional)
                - response_type (optional)
Optional:
    - mesh_owner
    - region
    - tags
    - tags_all
EOT

  type = map(object({
    mesh_name  = string
    name       = string
    mesh_owner = optional(string)
    region     = optional(string)
    tags       = optional(map(string))
    tags_all   = optional(map(string))
    spec = object({
      backend = optional(list(object({
        virtual_service = object({
          client_policy = optional(object({
            tls = optional(object({
              certificate = optional(object({
                file = optional(object({
                  certificate_chain = string
                  private_key       = string
                }))
                sds = optional(object({
                  secret_name = string
                }))
              }))
              enforce = optional(bool)
              ports   = optional(set(number))
              validation = object({
                subject_alternative_names = optional(object({
                  match = object({
                    exact = set(string)
                  })
                }))
                trust = object({
                  acm = optional(object({
                    certificate_authority_arns = set(string)
                  }))
                  file = optional(object({
                    certificate_chain = string
                  }))
                  sds = optional(object({
                    secret_name = string
                  }))
                })
              })
            }))
          }))
          virtual_service_name = string
        })
      })))
      backend_defaults = optional(object({
        client_policy = optional(object({
          tls = optional(object({
            certificate = optional(object({
              file = optional(object({
                certificate_chain = string
                private_key       = string
              }))
              sds = optional(object({
                secret_name = string
              }))
            }))
            enforce = optional(bool)
            ports   = optional(set(number))
            validation = object({
              subject_alternative_names = optional(object({
                match = object({
                  exact = set(string)
                })
              }))
              trust = object({
                acm = optional(object({
                  certificate_authority_arns = set(string)
                }))
                file = optional(object({
                  certificate_chain = string
                }))
                sds = optional(object({
                  secret_name = string
                }))
              })
            })
          }))
        }))
      }))
      listener = optional(list(object({
        connection_pool = optional(object({
          grpc = optional(object({
            max_requests = number
          }))
          http = optional(list(object({
            max_connections      = number
            max_pending_requests = optional(number)
          })))
          http2 = optional(list(object({
            max_requests = number
          })))
          tcp = optional(list(object({
            max_connections = number
          })))
        }))
        health_check = optional(object({
          healthy_threshold   = number
          interval_millis     = number
          path                = optional(string)
          port                = optional(number)
          protocol            = string
          timeout_millis      = number
          unhealthy_threshold = number
        }))
        outlier_detection = optional(object({
          base_ejection_duration = object({
            unit  = string
            value = number
          })
          interval = object({
            unit  = string
            value = number
          })
          max_ejection_percent = number
          max_server_errors    = number
        }))
        port_mapping = object({
          port     = number
          protocol = string
        })
        timeout = optional(object({
          grpc = optional(object({
            idle = optional(object({
              unit  = string
              value = number
            }))
            per_request = optional(object({
              unit  = string
              value = number
            }))
          }))
          http = optional(object({
            idle = optional(object({
              unit  = string
              value = number
            }))
            per_request = optional(object({
              unit  = string
              value = number
            }))
          }))
          http2 = optional(object({
            idle = optional(object({
              unit  = string
              value = number
            }))
            per_request = optional(object({
              unit  = string
              value = number
            }))
          }))
          tcp = optional(object({
            idle = optional(object({
              unit  = string
              value = number
            }))
          }))
        }))
        tls = optional(object({
          certificate = object({
            acm = optional(object({
              certificate_arn = string
            }))
            file = optional(object({
              certificate_chain = string
              private_key       = string
            }))
            sds = optional(object({
              secret_name = string
            }))
          })
          mode = string
          validation = optional(object({
            subject_alternative_names = optional(object({
              match = object({
                exact = set(string)
              })
            }))
            trust = object({
              file = optional(object({
                certificate_chain = string
              }))
              sds = optional(object({
                secret_name = string
              }))
            })
          }))
        }))
      })))
      logging = optional(object({
        access_log = optional(object({
          file = optional(object({
            format = optional(object({
              json = optional(list(object({
                key   = string
                value = string
              })))
              text = optional(string)
            }))
            path = string
          }))
        }))
      }))
      service_discovery = optional(object({
        aws_cloud_map = optional(object({
          attributes     = optional(map(string))
          namespace_name = string
          service_name   = string
        }))
        dns = optional(object({
          hostname      = string
          ip_preference = optional(string)
          response_type = optional(string)
        }))
      }))
    })
  }))
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        length(v.mesh_name) >= 1 && length(v.mesh_name) <= 255
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.backend == null || alltrue([for item in v.spec.backend : (length(item.virtual_service.virtual_service_name) >= 1 && length(item.virtual_service.virtual_service_name) <= 255)])
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.listener == null || alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.grpc == null || (item.connection_pool.grpc.max_requests >= 1)))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.listener == null || alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.http == null || alltrue([for item in item.connection_pool.http : (item.max_connections >= 1)])))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.listener == null || alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.http == null || alltrue([for item in item.connection_pool.http : (item.max_pending_requests == null || (item.max_pending_requests >= 1))])))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.listener == null || alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.http2 == null || alltrue([for item in item.connection_pool.http2 : (item.max_requests >= 1)])))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.listener == null || alltrue([for item in v.spec.listener : (item.connection_pool == null || (item.connection_pool.tcp == null || alltrue([for item in item.connection_pool.tcp : (item.max_connections >= 1)])))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.listener == null || alltrue([for item in v.spec.listener : (item.outlier_detection == null || (item.outlier_detection.max_ejection_percent >= 0 && item.outlier_detection.max_ejection_percent <= 100))])
      )
    ])
    error_message = "must be between 0 and 100"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.listener == null || alltrue([for item in v.spec.listener : (item.outlier_detection == null || (item.outlier_detection.max_server_errors >= 1))])
      )
    ])
    error_message = "must be at least 1"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.listener == null || alltrue([for item in v.spec.listener : (item.tls == null || (item.tls.validation == null || (item.tls.validation.trust.sds == null || (length(item.tls.validation.trust.sds.secret_name) >= 1 && length(item.tls.validation.trust.sds.secret_name) <= 255))))])
      )
    ])
    error_message = "must be between 1 and 255 characters"
  }
  validation {
    condition = alltrue([
      for k, v in var.appmesh_virtual_nodes : (
        v.spec.service_discovery == null || (v.spec.service_discovery.aws_cloud_map == null || (length(v.spec.service_discovery.aws_cloud_map.namespace_name) >= 1 && length(v.spec.service_discovery.aws_cloud_map.namespace_name) <= 1024))
      )
    ])
    error_message = "must be between 1 and 1024 characters"
  }
  # Note: 32 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

