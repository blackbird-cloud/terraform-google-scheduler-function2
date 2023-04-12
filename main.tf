module "function2" {
  source  = "blackbird-cloud/function2/google"
  version = "0.0.1"

  available_memory                 = var.available_memory
  available_cpu                    = var.available_cpu
  max_instance_request_concurrency = var.max_instance_request_concurrency
  all_traffic_on_latest_revision   = var.all_traffic_on_latest_revision
  min_instance_count               = var.min_instance_count
  max_instance_count               = var.max_instance_count
  location                         = var.location
  description                      = var.description
  entry_point                      = var.entry_point
  environment_variables            = var.environment_variables
  labels                           = var.labels
  name                             = var.name
  project_id                       = var.project_id
  region                           = var.region
  runtime                          = var.runtime
  secret_environment_variables     = var.secret_environment_variables
  source_directory                 = var.source_directory
  source_dependent_files           = var.source_dependent_files
  files_to_exclude_in_source_dir   = var.files_to_exclude_in_source_dir
  timeout_s                        = var.timeout_s
  bucket_labels                    = var.bucket_labels
  service_account_email            = var.service_account_email
  bucket_name                      = var.bucket_name
  create_bucket                    = var.create_bucket
  bucket_force_destroy             = var.bucket_force_destroy
  ingress_settings                 = var.ingress_settings
  vpc_connector_egress_settings    = var.vpc_connector_egress_settings
  vpc_connector                    = var.vpc_connector
  log_bucket                       = var.log_bucket
  log_object_prefix                = var.log_object_prefix
  build_environment_variables      = var.build_environment_variables
}

resource "google_service_account" "default" {
  project      = var.project_id
  account_id   = substr("${var.name}-scheduler-sa", 0, 28)
  description  = "Cloud Scheduler service account; used to trigger scheduled Cloud Run jobs."
  display_name = "${var.name}-scheduler-sa"
}

resource "google_project_iam_member" "run_invoker" {
  project = var.project_id

  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.default.email}"
}

data "google_cloud_run_service" "default" {
  depends_on = [
    module.function2
  ]
  project = var.project_id

  name     = var.name
  location = var.location
}

resource "google_cloud_scheduler_job" "scheduler" {
  name        = var.name
  description = var.description
  paused      = var.paused
  region      = var.scheduler_region

  schedule = var.schedule # "0 3 * * *"

  time_zone        = var.time_zone # "Europe/Amsterdam"
  project          = var.project_id
  attempt_deadline = var.attempt_deadline # "600s"

  retry_config {
    retry_count = var.retry_count
  }
  http_target {
    http_method = "POST"
    uri         = data.google_cloud_run_service.default.status[0].url

    oidc_token {
      service_account_email = google_service_account.default.email
    }
  }
}
