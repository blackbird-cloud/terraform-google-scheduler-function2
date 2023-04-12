variable "available_memory" {
  type        = string
  default     = "256Mi"
  description = "(Optional) The amount of memory available for a function. Defaults to 256M. Supported units are k, M, G, Mi, Gi. If no unit is supplied the value is interpreted as bytes."
}

variable "available_cpu" {
  type        = string
  default     = ""
  description = "(Optional) The number of CPUs used in a single container instance. Default value is calculated from available memory."
}

variable "max_instance_request_concurrency" {
  type        = number
  default     = 1
  description = "(Optional) Sets the maximum number of concurrent requests that each instance can receive. Defaults to 1."
}

variable "all_traffic_on_latest_revision" {
  type        = bool
  default     = true
  description = " (Optional) Whether 100% of traffic is routed to the latest revision. Defaults to true."
}

variable "min_instance_count" {
  type        = number
  default     = null
  description = "(Optional) The limit on the minimum number of function instances that may coexist at a given time."
}

variable "max_instance_count" {
  type        = number
  default     = 100
  description = "(Optional) The limit on the maximum number of function instances that may coexist at a given time."
}

variable "location" {
  description = "(Optional) The location of this cloud function."
  default     = ""
  type        = string
}

variable "description" {
  type        = string
  default     = "Processes events."
  description = "The description of the function."
}

variable "entry_point" {
  type        = string
  description = "The name of a method in the function source which will be invoked when the function is executed."
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "A set of key/value environment variable pairs to assign to the function."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "A set of key/value label pairs to assign to the Cloud Function."
}

variable "name" {
  type        = string
  description = "The name to apply to any nameable resources."
}

variable "project_id" {
  type        = string
  description = "The ID of the project to which resources will be applied."
}

variable "region" {
  type        = string
  description = "The region in which resources will be applied."
}

variable "scheduler_region" {
  type        = string
  description = "The region in which the scheduler resources will be applied, not available in all regions."
}

variable "runtime" {
  type        = string
  description = "The runtime in which the function will be executed."
}

variable "secret_environment_variables" {
  type        = list(map(string))
  default     = []
  description = "A list of maps which contains key, project_id, secret_name (not the full secret id) and version to assign to the function as a set of secret environment variables."
}

variable "source_directory" {
  type        = string
  description = "The pathname of the directory which contains the function source code."
}

variable "source_dependent_files" {
  type = list(object({
    filename = string
    id       = string
  }))
  description = "A list of any Terraform created `local_file`s that the module will wait for before creating the archive."
  default     = []
}

variable "files_to_exclude_in_source_dir" {
  type        = list(string)
  description = "Specify files to ignore when reading the source_dir"
  default     = []
}

variable "timeout_s" {
  type        = number
  default     = 60
  description = "The amount of time in seconds allotted for the execution of the function."
}

variable "bucket_labels" {
  type        = map(string)
  default     = {}
  description = "A set of key/value label pairs to assign to the function source archive bucket."
}

variable "service_account_email" {
  type        = string
  default     = ""
  description = "The service account to run the function as."
}

variable "bucket_name" {
  type        = string
  default     = ""
  description = "The name to apply to the bucket. Will default to a string of the function name."
}

variable "create_bucket" {
  type        = bool
  default     = true
  description = "Whether to create a new bucket or use an existing one. If false, `bucket_name` should reference the name of the alternate bucket to use."
}

variable "bucket_force_destroy" {
  type        = bool
  default     = false
  description = "When deleting the GCS bucket containing the cloud function, delete all objects in the bucket first."
}

variable "ingress_settings" {
  type        = string
  default     = "ALLOW_ALL"
  description = "The ingress settings for the function. Allowed values are ALLOW_ALL, ALLOW_INTERNAL_AND_GCLB and ALLOW_INTERNAL_ONLY. Changes to this field will recreate the cloud function."
}

variable "vpc_connector_egress_settings" {
  type        = string
  default     = "PRIVATE_RANGES_ONLY"
  description = "The egress settings for the connector, controlling what traffic is diverted through it. Allowed values are ALL_TRAFFIC and PRIVATE_RANGES_ONLY. If unset, this field preserves the previously set value."
}

variable "vpc_connector" {
  type        = string
  default     = null
  description = "The VPC Network Connector that this cloud function can connect to. It should be set up as fully-qualified URI. The format of this field is projects/*/locations/*/connectors/*."
}

variable "log_bucket" {
  type        = string
  default     = null
  description = "Log bucket"
}

variable "log_object_prefix" {
  type        = string
  default     = null
  description = "Log object prefix"
}

variable "build_environment_variables" {
  type        = map(string)
  default     = {}
  description = "A set of key/value environment variable pairs available during build time."
}

variable "paused" {
  type        = string
  description = "(Optional) Sets the job to a paused state. Jobs default to being enabled when this property is not set."
}

variable "schedule" {
  type        = string
  description = "(Optional) Describes the schedule on which the job will be executed."
}

variable "time_zone" {
  type        = string
  description = "(Optional) Specifies the time zone to be used in interpreting schedule. The value of this field must be a time zone name from the tz database."
}

variable "attempt_deadline" {
  type        = string
  description = "(Optional) The deadline for job attempts."
}

variable "retry_count" {
  type        = number
  description = " (Optional) The number of attempts that the system will make to run a job using the exponential backoff procedure described by maxDoublings. Values greater than 5 and negative values are not allowed."
}
