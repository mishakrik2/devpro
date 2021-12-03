# Define a DNS zone for domain.
#resource "cloudflare_zone" "misha-krik-xyz" {
# zone = "misha-krik.xyz"
#}

# CNAME for root domain.

#resource "cloudflare_record" "root-misha-krik-xyz" {
#  zone_id   = "${cloudflare_zone.misha-krik-xyz.id}"
#  name      = "@"
#  value     = "${aws_alb.ec2-alb.dns_name}"
#  type      = "CNAME"
#  proxied   = true
#  ttl       = 1
#}

# CNAME for WWW subdomain. 

resource "cloudflare_record" "fallback-misha-krik-xyz" {
  zone_id   = "9c2ab889414820912b6abd15a5e75053"
  name      = "fallback"
  value     = "${aws_alb.ec2-alb.dns_name}"
  type      = "CNAME"
  proxied   = true
  ttl       = 1
}

# Bastion will have its IP address exposed. not sure if this record is needed at all. Will remove later

resource "cloudflare_record" "bastion-misha-krik-xyz" {
  zone_id   = "9c2ab889414820912b6abd15a5e75053"
  name      = "bastion.fallback"
  value     = "${aws_alb.ec2-alb.dns_name}"
  type      = "CNAME"
  proxied   = false
  ttl       = 1
}

# Enable / Disable Cloudflare SSL and https rewrites

resource "cloudflare_zone_settings_override" "misha-krik-xyz-settings" {
    zone_id = "9c2ab889414820912b6abd15a5e75053"
    settings {
        automatic_https_rewrites = "off"
        ssl = "off"
    }
}
