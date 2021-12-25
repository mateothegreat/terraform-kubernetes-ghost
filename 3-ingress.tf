resource "kubernetes_ingress" "ingress" {

    metadata {

        name      = var.name
        namespace = var.namespace

        annotations = {

            "cert-manager.io/cluster-issuer"           = "letsencrypt"
            "nginx.ingress.kubernetes.io/ssl-redirect" = "true"

        }

    }

    spec {

        tls {

            hosts       = var.hostnames
            secret_name = var.name

        }

        dynamic rule {

            for_each = var.hostnames

            content {

                host = rule.value

                http {

                    path {

                        path = "/"

                        backend {

                            service_name = var.name
                            service_port = 2368

                        }

                    }

                }

            }

        }

    }

}
