data "aws_route53_zone" "this" {
  count = length(var.domains)

  name = var.domains[count.index]
}

resource "aws_route53_record" "public" {
  count = length(var.domains)

  zone_id = data.aws_route53_zone.this[count.index].zone_id
  name    = format("*.%s", var.domains[count.index])
  type    = "A"

  alias {
    zone_id                = aws_lb.public.zone_id
    name                   = aws_lb.public.dns_name
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "internal" {
  count = length(var.domains)

  zone_id = data.aws_route53_zone.this[count.index].zone_id
  name    = format("*.in.%s", var.domains[count.index])
  type    = "A"

  alias {
    zone_id                = aws_lb.internal.zone_id
    name                   = aws_lb.internal.dns_name
    evaluate_target_health = false
  }
}
