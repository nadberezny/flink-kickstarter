resource "helm_release" "akhq" {
  name             = "akhq"
  repository       = "https://akhq.io/"
  chart            = "akhq"
  namespace        = local.namespace_services
  create_namespace = true
  recreate_pods    = true
  reset_values     = true
  atomic           = true


  set {
    name = "secrets.akhq.connections.kafka-cluster.properties.bootstrap\\.servers"
    value = join(
      "\\,",
      [
        local.kafka_bootstrap_server
      ]
    )
  }

  set {
    name  = "secrets.akhq.connections.kafka-cluster.schema-registry.url"
    value = local.schema_registry_url
  }

  set {
    name  = "ingress.enabled"
    value = "true"
    type  = "string"
  }

  set {
    name  = "ingress.hosts[0]"
    value = "localhost"
  }

  set {
    name  = "ingress.ingressClassName"
    value = "nginx"
  }

  depends_on = [
    helm_release.kafka,
    helm_release.schema-registry,
    helm_release.nginx-ingress
  ]
}
