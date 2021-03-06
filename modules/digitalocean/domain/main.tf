resource "digitalocean_project" "domains" {
  name          = "Domains"
  description   = "Project to contain Coding Buddies domains"
  purpose       = "Organization"
}

resource "digitalocean_domain" "codingbuddies_dev" {
  name          = "codingbuddies.dev"
}

# MX records for email
resource "digitalocean_record" "codingbuddies_email_txt" {
  domain        = digitalocean_domain.codingbuddies_dev.name
  type          = "TXT"
  name          = "@"
  value         = "v=spf1 include:spf.privateemail.com ~all"
}

resource "digitalocean_record" "codingbuddies_email_mx" {
  domain        = digitalocean_domain.codingbuddies_dev.name
  type          = "MX"
  name          = "@"
  value         = "mx${count.index + 1}.privateemail.com."
  count         = 2
  priority      = 10
}

# TXT record for GitHub verification
resource "digitalocean_record" "codingbuddies_github_verify" {
  domain        = digitalocean_domain.codingbuddies_dev.name
  type          = "TXT"
  name          = "_github-challenge-Coding-Buddies"
  value         = "22954ce2fb"
}

resource "digitalocean_project_resources" "domains" {
  project       = digitalocean_project.domains.id
  resources     = [
    digitalocean_domain.codingbuddies_dev.urn
  ]
}

