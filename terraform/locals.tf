locals {
  namespace_applications   = "default"
  namespace_services       = "default"
  flink_operator_version   = "1.7.0"
  flink_operator_image_tag = "be07be7"
  flink_ha_dir             = "high-availability/flink"
  flink_checkpoints_dir    = "checkpoints/flink"
  flink_savepoints_dir     = "savepoints/flink"
  kafka_bootstrap_server  = "kafka.${local.namespace_services}.svc.cluster.local:9092"
  schema_registry_url      = "http://schema-registry.${local.namespace_services}.svc.cluster.local:8081"
  minio_user               = "admin"
  minio_password           = "adminadmin"
}
