# Ghost blog on kubernetes

This terraform module will deploy [ghost](https://ghost.org) blog on kubernetes through terraform.

The following resources will be created:

* Deployment
* Service
* Ingress

# Example

The following will create two deployments for each site listed in the sites list.

### locals.tf

```hcl
locals {

    sites = [

        {

            name      = "matthewdavis.io"
            hostnames = [ "matthewdavis.io" ]

        }, {

            name      = "garagefarm-ai"
            hostnames = [ "garagefarm.ai" ]

        }

    ]

}
```

### main.tf

```hcl 
module "site" {

    count = length(local.sites)

    name              = local.sites[ count.index ].name
    namespace         = "default"
    
    hostnames         = local.sites[ count.index ].hostnames
    
    database_host     = "changeme"
    database_username = "changeme"
    database_password = "changeme"
    database_name     = replace(local.sites[ count.index ].name, "-", "_")
    
    request_cpu       = "250m"
    request_memory    = "200Mi"
    limit_cpu         = "500m"
    limit_memory      = "250Mi"
    
    replicas          = 50
    
    #
    # Force pods to only run on the nodes that has the label
    # "role" and the value "services" (optional).
    #
    node_selector = {

        role = "services"

    }

}
```
