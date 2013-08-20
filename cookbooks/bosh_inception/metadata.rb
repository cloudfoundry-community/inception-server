name "bosh_inception"
version "0.1.0"
description "Become an inception server to deploy/develop Bosh and bosh releases"
long_description  IO.read(File.expand_path('../README.md', __FILE__))
maintainer "Dr Nic Williams"
maintainer_email "drnicwilliams@gmail.com"

supports "ubuntu"

depends "apt"
depends "sudo"
depends "chruby"
depends "hub"

attribute "git",
  display_name: "Git",
  description: "Hash of git config attributes",
  type: "hash",
  required: "recommended"

attribute "git/name",
  display_name: "Git user's name",
  description: "Name for git user",
  type: "string",
  required: "recommended"

attribute "git/email",
  display_name: "Git user's email",
  description: "Email for git user",
  type: "string",
  required: "recommended"

