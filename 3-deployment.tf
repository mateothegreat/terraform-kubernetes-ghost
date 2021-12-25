resource "kubernetes_deployment" "deployment" {

    metadata {

        name      = var.name
        namespace = var.namespace

        labels = {

            app = var.name

        }

    }

    spec {

        replicas = var.replicas

        selector {

            match_labels = {

                app = var.name

            }

        }

        template {

            metadata {

                name = var.name

                labels = {

                    app = var.name

                }

            }

            spec {

                node_selector = var.node_selector

                container {

                    name  = var.name
                    image = var.image

                    port {

                        container_port = 2368
                        protocol       = "TCP"

                    }

                    resources {

                        requests = {

                            cpu    = var.request_cpu
                            memory = var.request_memory

                        }

                        limits = {

                            cpu    = var.limit_cpu
                            memory = var.limit_memory

                        }

                    }

                    liveness_probe {

                        tcp_socket {

                            port = 2368

                        }

                        initial_delay_seconds = 15
                        period_seconds        = 15

                    }

                    readiness_probe {

                        tcp_socket {

                            port = 2368

                        }

                        initial_delay_seconds = 15
                        period_seconds        = 15

                    }

                    env {

                        name  = "database__client"
                        value = "mysql"

                    }

                    env {

                        name  = "database__connection__host"
                        value = var.database_host

                    }

                    env {

                        name  = "database__connection__user"
                        value = var.database_username

                    }

                    env {

                        name  = "database__connection__password"
                        value = var.database_password

                    }

                    env {

                        name  = "database__connection__database"
                        value = var.database_name

                    }

                    env {

                        name  = "url"
                        value = "https://${ var.hostnames[ 0 ] }"

                    }

                    volume_mount {

                        name       = "content"
                        mount_path = "/var/lib/ghost/content"

                    }

                }

                volume {

                    name = "content"

                    nfs {

                        server = "nfs.default.svc.cluster.local"
                        path   = "/exports/${ var.name }"

                    }

                }

            }

        }

    }

}

