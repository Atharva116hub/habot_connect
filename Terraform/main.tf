provider "google" {
  project = "project-f0895e8f-5246-4fc6-b97"
  region  = "us-central1"
}

resource "google_storage_bucket" "raw_landing" {
  name                        = "habot-d0-raw-landing-atharva"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "raw_landing_writer" {
  bucket = google_storage_bucket.raw_landing.name
  role   = "roles/storage.objectCreator"
  member = "user:atharva.topre116@gmail.com"
}

resource "google_bigquery_dataset" "staged_enforced" {
  dataset_id  = "d1_staged_enforced"
  location    = "US"
  description = "Validated, schema-enforced student onboarding data"
}

resource "google_bigquery_dataset_iam_member" "reader_access" {
  dataset_id = google_bigquery_dataset.staged_enforced.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:atharva.topre116@gmail.com"
}

resource "google_bigquery_table" "student_onboarding" {
  dataset_id          = google_bigquery_dataset.staged_enforced.dataset_id
  table_id            = "student_onboarding"
  deletion_protection = false
  schema              = <<SCHEMA
[
  {"name": "student_name", "type": "STRING", "mode": "REQUIRED"},
  {"name": "age", "type": "INTEGER", "mode": "REQUIRED"},
  {"name": "guardian_email", "type": "STRING", "mode": "REQUIRED"},
  {"name": "region", "type": "STRING", "mode": "REQUIRED"}
]
SCHEMA
}
