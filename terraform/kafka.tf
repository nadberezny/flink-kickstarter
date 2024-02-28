resource "helm_release" "kafka" {
  name             = "kafka"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "kafka"
  namespace        = local.namespace_services
  create_namespace = true

  depends_on = [
    module.k3d_cluster
  ]

  set {
    name  = "replicaCount"
    value = "3"
  }

  set {
    name  = "controller.replicaCount"
    value = "3"
  }

  set {
    name  = "image.tag"
    value = "3.5.1-debian-11-r25"
  }

  set {
    name  = "provisioning.enabled"
    value = true
  }

  set {
    name  = "listeners.client.protocol"
    value = "PLAINTEXT"
  }

  set {
    name  = "externalAccess.enabled"
    value = "true"
  }

  set {
    name  = "externalAccess.controller.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "externalAccess.controller.service.domain"
    value = "localhost"
  }

  set {
    name  = "externalAccess.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "externalAccess.service.domain"
    value = "localhost"
  }

  set {
    name  = "extraConfig"
    value = <<EOF
transaction.max.timeout.ms=86400000
default.replication.factor=1
offsets.topic.replication.factor=1
transaction.state.log.replication.factor=2
transaction.state.log.min.isr=1
transaction.state.log.num.partitions=1
EOF
  }

  set {
    name  = "provisioning.replicationFactor"
    value = "1"
  }

  set {
    name  = "provisioning.topics[0].name"
    value = "events"
  }
  set {
    name  = "provisioning.topics[0].partitions"
    value = "1"
  }

}
