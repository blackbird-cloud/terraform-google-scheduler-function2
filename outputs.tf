output "function2" {
  description = "The google cloud function2."
  value       = module.function2
}

output "cloud_run_service" {
  description = "The google cloud run service."
  value       = data.google_cloud_run_service.default
}
