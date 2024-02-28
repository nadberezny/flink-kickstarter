resource "helm_release" "schema-registry" {
  name             = "schema-registry"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "schema-registry"
  namespace        = local.namespace_services
  create_namespace = true

  depends_on = [helm_release.kafka]

  set {
    name  = "kafka.enabled"
    value = false
  }

  set {
    name  = "replicaCount"
    value = "1"
  }

  set {
    name  = "image.tag"
    value = "7.3.2-debian-11-r6"
  }

  values = [
    <<EOF
    configuration: |-
      listeners = http://0.0.0.0:8081
      kafkastore.bootstrap.servers = PLAINTEXT://${local.kafka_bootstrap_server}
      host.name = schema-registry-0.schema-registry-headless.${local.namespace_services}.svc.cluster.local
      kafkastore.topic = _schemas
      kafkastore.topic.replication.factor = 1
      kafkastore.security.protocol = PLAINTEXT
      kafkastore.sasl.mechanism = PLAIN
      kafkastore.ssl.endpoint.identification.algorithm =
      ssl.client.authentication = NONE
      inter.instance.protocol = http
      avro.compatibility.level = backward
      debug = false
    EOF
  ]

  set {
    name  = "externalKafka.brokers"
    value = "{PLAINTEXT://${local.kafka_bootstrap_server}}"
  }

  set {
    name  = "kafka.auth.clientProtocol"
    value = "plaintext"
  }

  set {
    name  = "kafka.service.ports.client"
    value = 9092
  }

  set {
    name  = "externalKafka.auth.protocol"
    value = "plaintext"
  }
}
