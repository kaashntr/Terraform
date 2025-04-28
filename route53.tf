resource "aws_route53_zone" "zone_53" {
  name = "kaashntr.pp.ua"
}

resource "aws_route53_record" "cname_record" {
  zone_id = aws_route53_zone.zone_53.zone_id
  name    = "app.kaashntr.pp.ua"
  
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.nlb.dns_name]
}
