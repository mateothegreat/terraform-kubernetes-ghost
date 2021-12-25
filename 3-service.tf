resource "kubernetes_service" "service" {

    metadata {

        name      = var.name
        namespace = var.namespace

        labels = {

            app = var.name

        }

    }

    spec {

        selector = {

            app = var.name

        }

        port {

            port        = 2368
            target_port = 2368
            protocol    = "TCP"

        }

    }

}
