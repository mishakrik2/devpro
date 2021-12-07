# Registration on the acme server

resource "tls_private_key" "acme_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = "${tls_private_key.acme_key.private_key_pem}"
  email_address   = "mishakrik2@gmail.com"
}

# Generate certificate for the domain name. 

resource "acme_certificate" "certificate" {
  account_key_pem           = "${acme_registration.reg.account_key_pem}"
  common_name               = "misha-krik.xyz"
  subject_alternative_names = ["www.misha-krik.xyz"]
  dns_challenge {
    provider = "cloudflare"
  }
}