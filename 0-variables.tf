variable "name" {

    type        = string
    description = "name of this deployment"

}

variable "namespace" {

    type        = string
    description = "namespace to deploy resources in to"

}

variable "hostnames" {

    type        = list(string)
    description = "hostname(s) for this site (i.e.: matthewdavis.io"

}

variable "image" {

    type        = string
    description = "docker image"
    default     = "ghost:4-alpine"

}

variable "replicas" {

    type        = number
    description = "number of replicas"
    default     = 1

}

variable "request_cpu" {

    type    = string
    default = "50m"

}

variable "request_memory" {

    type    = string
    default = "50Mi"

}

variable "limit_cpu" {

    type    = string
    default = "1000m"

}

variable "limit_memory" {

    type    = string
    default = "200Mi"

}

variable "database_host" {

    type        = string
    description = "database hostname or ip"

}

variable "database_username" {

    type        = string
    description = "database username"

}

variable "database_password" {

    type        = string
    description = "database password"

}

variable "database_name" {

    type        = string
    description = "database name"

}

variable "node_selector" {

    type        = map(string)
    description = "node label to require to schedule pods on them"
    default     = null

}

variable "use_loadbalancer" {

    type        = bool
    description = "sets the service type to LoadBalancer (public facing) vs. ClusterIP (internal only)"
    default     = false

}

variable "create_ingress" {

    type        = bool
    description = "create an Ingress object for mapping hostnames via an ingress-controller"
    default     = false

}
