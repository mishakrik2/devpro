# Define a DNS zone for domain.
resource "cloudflare_zone" "misha-krik-xyz" {
 zone = "misha-krik.xyz"
}

# CNAME for root domain.

resource "cloudflare_record" "root-misha-krik-xyz" {
  zone_id   = "${cloudflare_zone.misha-krik-xyz.id}"
  name      = "@"
  value     = "${aws_alb.ec2-alb.dns_name}"
  type      = "CNAME"
  proxied   = true
  ttl       = 1
}

# CNAME for WWW subdomain. 

resource "cloudflare_record" "www-misha-krik-xyz" {
  zone_id   = "${cloudflare_zone.misha-krik-xyz.id}"
  name      = "www"
  value     = "${aws_alb.ec2-alb.dns_name}"
  type      = "CNAME"
  proxied   = true
  ttl       = 1
}

# Bastion will have its IP address exposed. not sure if this record is needed at all. Will remove later

resource "cloudflare_record" "bastion-misha-krik-xyz" {
  zone_id   = "${cloudflare_zone.misha-krik-xyz.id}"
  name      = "bastion"
  value     = "${aws_alb.ec2-alb.dns_name}"
  type      = "CNAME"
  proxied   = false
  ttl       = 1
}

# Enable / Disable Cloudflare SSL and https rewrites

resource "cloudflare_zone_settings_override" "misha-krik-xyz-settings" {
    zone_id = "${cloudflare_zone.misha-krik-xyz.id}"
    settings {
        automatic_https_rewrites = "off"
        ssl = "off"
    }
}