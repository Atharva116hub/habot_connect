provider "google" {
  project = "habot-assessment"
  region  = "us-central1"
}

# D0 Raw Landing bucket
resource "google_storage_bucket" "raw_landing" {
  name                        = "habot-d0-raw-landing-YOURNAME"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}

# Least-privilege IAM: only you can write to raw landing
resource "google_storage_bucket_iam_member" "raw_landing_writer" {
  bucket = google_storage_bucket.raw_landing.name
  role   = "roles/storage.objectCreator"
  member = "user:YOUR_GMAIL@gmail.com"
}

# D1 Staged/Enforced dataset
resource "google_bigquery_dataset" "staged_enforced" {
  dataset_id  = "d1_staged_enforced"
  location    = "US"
  description = "Validated, schema-enforced student onboarding data"
}

# Least-privilege IAM: only you can read the staged dataset
resource "google_bigquery_dataset_iam_member" "reader_access" {
  dataset_id = google_bigquery_dataset.staged_enforced.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "user:YOUR_GMAIL@gmail.com"
}

# Table with enforced schema
resource "google_bigquery_table" "student_onboarding" {
  dataset_id = google_bigquery_dataset.staged_enforced.dataset_id
  table_id   = "student_onboarding"
  schema     = <<EOF
[
  {"name": "student_name", "type": "STRING", "mode": "REQUIRED"},
  {"name": "age", "type": "INTEGER", "mode": "REQUIRED"},
  {"name": "guardian_email", "type": "STRING", "mode": "REQUIRED"},
  {"name": "region", "type": "STRING", "mode": "REQUIRED"}
]
EOF
}
