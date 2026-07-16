variable "environments" {
  default     = ["dev"]
  description = "List of Kubernetes environments (clusters) to deploy"
  sensitive   = false
  type = list(string)
}

variable "gitops_tool" {
  type        = string
  description = "The GitOps operator to bootstrap into the KIND cluster ('argo', 'flux', or 'none')"
  default     = "argo"

  validation {
    condition     = contains(["argo", "flux", "none"], var.gitops_tool)
    error_message = "The gitops_tool variable must be 'argo', 'flux', or 'none'."
  }
}