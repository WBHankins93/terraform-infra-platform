output "autoscaler_status" {
  value = helm_release.cluster_autoscaler.status
}
