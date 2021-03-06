# aws_lb_listener

resource "aws_lb_listener" "public_http" {
  load_balancer_arn = aws_lb.public.arn

  port     = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "public_https" {
  load_balancer_arn = aws_lb.public.arn

  port            = "443"
  protocol        = "HTTPS"
  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = data.aws_acm_certificate.public_https[0].arn

  default_action {
    type = "forward"

    forward {
      dynamic "target_group" {
        for_each = local.tgs
        content {
          arn    = target_group.value.public_http
          weight = target_group.value.weight
        }
      }

      stickiness {
        enabled  = false
        duration = 600
      }
    }
  }
}

resource "aws_lb_listener_rule" "public_https--argocd" {
  listener_arn = aws_lb_listener.public_https.arn
  priority     = 1

  condition {
    host_header {
      values = ["argocd.kkarin.com"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_http_0.arn
  }
}

resource "aws_lb_listener_rule" "public_https--applicationset" {
  listener_arn = aws_lb_listener.public_https.arn
  priority     = 3

  condition {
    host_header {
      values = ["appset.kkarin.com"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_http_0.arn
  }
}

resource "aws_lb_listener_rule" "public_https--grafana" {
  listener_arn = aws_lb_listener.public_https.arn
  priority     = 5

  condition {
    host_header {
      values = ["grafana.kkarin.com"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_http_0.arn
  }
}

resource "aws_lb_listener_rule" "public_https--a" {
  listener_arn = aws_lb_listener.public_https.arn
  priority     = 11

  condition {
    host_header {
      values = ["*.dev-a.kkarin.com"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_http_a.arn
  }
}

resource "aws_lb_listener_rule" "public_https--b" {
  listener_arn = aws_lb_listener.public_https.arn
  priority     = 12

  condition {
    host_header {
      values = ["*.dev-b.kkarin.com"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_http_b.arn
  }
}

# acm

data "aws_acm_certificate" "public_https" {
  count = length(var.domains)

  domain      = var.domains[count.index]
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_lb_listener_certificate" "public_https" {
  count = length(var.domains) > 1 ? length(var.domains) - 1 : 0

  listener_arn    = aws_lb_listener.public_https.arn
  certificate_arn = data.aws_acm_certificate.public_https[count.index + 1].arn
}
