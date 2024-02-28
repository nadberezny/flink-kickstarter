resource "helm_release" "flink_operator" {
  name             = "flink-operator"
  repository       = "https://downloads.apache.org/flink/flink-kubernetes-operator-${local.flink_operator_version}/"
  chart            = "flink-kubernetes-operator"
  namespace        = local.namespace_applications
  create_namespace = true

  set {
    name  = "image.tag"
    value = local.flink_operator_image_tag
  }

  depends_on = [
    module.k3d_cluster, helm_release.cert-manager
  ]
}
