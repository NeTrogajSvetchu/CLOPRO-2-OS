//целевая группа
resource "yandex_alb_target_group" "alb-group" {
  name           = "group-vms"

  target {
    subnet_id    = var.subnet_ids
    ip_address   = var.group_wm1
  }

  target {
    subnet_id    = var.subnet_ids
    ip_address   = var.group_wm2
  }

  target {
    subnet_id    = var.subnet_ids
    ip_address   = var.group_wm3
  }
/*
  depends_on = [
    yandex_compute_instance_group.group-vms
]
*/
}

//группа бэкенда
resource "yandex_alb_backend_group" "backend-group" {
    depends_on = [
    yandex_alb_target_group.alb-group
]
  name                     = "backend-balancer"
  session_affinity {
    connection {
      source_ip = true
    }
  }

  http_backend {
    name                   = "http-backend"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.alb-group.id]
    load_balancing_config {
      panic_threshold      = 90
    }    
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15 
      http_healthcheck {
        path               = "/"
      }
    }
  }

}
//HTTP-роутер

resource "yandex_alb_http_router" "http-router" {
  name          = "http-router"
  labels        = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}

resource "yandex_alb_virtual_host" "my-virtual-host" {
  name                    = "virtual-host"
  http_router_id          = yandex_alb_http_router.http-router.id
  route {
    name                  = "route-http"
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.backend-group.id
        timeout           = "60s"
      }
    }
  }
depends_on = [
    yandex_alb_backend_group.backend-group
]
}

//L7-балансировщик

resource "yandex_alb_load_balancer" "application-balancer" {
  name        = "app-balancer"
  network_id  = var.id

  allocation_policy {
    location {
      zone_id   = var.default_zone
      subnet_id = var.subnet_ids
    }
  }

  listener {
    name = "listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.http-router.id
      }
    }
  }

 depends_on = [
    yandex_alb_http_router.http-router
] 
}