# Resources

resource "haproxy_frontend" "my-frontend" {
  name = "my-frontend"

  # for more options go to https://registry.terraform.io/providers/matthisholleville/haproxy/latest/docs/resources/frontend#optional
}

resource "haproxy_maps" "my-key" {
  map   = "ratelimit"
  key   = "/metrics"
  value = "50"

  # for more options go to https://registry.terraform.io/providers/matthisholleville/haproxy/latest/docs/resources/maps#optional
}
