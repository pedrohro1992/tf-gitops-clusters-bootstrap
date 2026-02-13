resource "null_resource" "create_storage" {

  triggers = {
    cluster_name = var.cluster_name
  }

  provisioner "local-exec" {
    when    = create
    command = var.create_cluster_storage ? "bash ${path.module}/scripts/create-storage.sh ${local.storage_path}" : "echo 'Skipping storage creation'"
  }
}
