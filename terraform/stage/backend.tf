terraform {
  backend "gcs" {
    bucket = "saykinsbucket"
    prefix = "terraform/state"
  }
}
