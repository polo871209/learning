group "default" {
  targets = ["app", "migrations"]
}

target "app" {
  context = "./api"
  dockerfile = "Dockerfile"
  target = "app"
  tags = ["api:local"]
}

target "migrations" {
  context = "./api"
  dockerfile = "Dockerfile"
  target = "migrations"
  tags = ["api-migrations:local"]
}
