resource "helm_release" "minio" {
  name       = "minio"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "minio"

  namespace        = "cluster-services"
  create_namespace = true

  depends_on = [
    module.k3d_cluster
  ]

  set {
    name  = "image.tag"
    value = "2023.3.13-debian-11-r0"
  }

  set {
    name  = "clientImage.tag"
    value = "2023.2.28-debian-11-r4"
  }

  set {
    name  = "auth.rootUser"
    value = local.minio_user
  }

  set {
    name  = "auth.rootPassword"
    value = local.minio_password
  }

  set {
    name  = "defaultBuckets"
    value = "${local.flink_ha_dir} ${local.flink_checkpoints_dir} ${local.flink_savepoints_dir}"
  }
}
