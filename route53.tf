resource "aws_route53_zone" "zone_53" {
  name = "kaashntr.pp.ua"
}

resource "aws_route53_record" "cname_record" {
  zone_id = aws_route53_zone.zone_53.zone_id
  name    = "app.kaashntr.pp.ua"
  type    = "A"

  alias {
    name                   = aws_lb.nlb.dns_name
    zone_id                = aws_lb.nlb.zone_id
    evaluate_target_health = true
  }
}
