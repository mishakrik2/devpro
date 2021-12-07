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

# Import the certificate into ACM.

resource "aws_acm_certificate" "cert" {
  private_key        =  acme_certificate.certificate.private_key_pem   
  certificate_body   =  acme_certificate.certificate.certificate_pem 
  certificate_chain  =  acme_certificate.certificate.issuer_pem
  depends_on         =  [acme_certificate.certificate,tls_private_key.acme_key,acme_registration.reg]
  lifecycle {
    create_before_destroy = true
  }
}