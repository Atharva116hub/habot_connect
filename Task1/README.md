# HabotConnect Hiring Project — Task 1: Terraform Secure Staging Provisioning

**Submitted by:** Atharva Topre
**Contact:** atharva.topre116@gmail.com

## What this does
Provisions a GCS bucket (D0 raw landing) and a BigQuery dataset + table
(D1 staged/enforced) with least-privilege IAM bindings and a row-level
security policy restricting read access by region.

## Resources created
- GCS bucket: `habot-d0-raw-landing-atharva`
- BigQuery dataset: `d1_staged_enforced`
- BigQuery table: `student_onboarding`
- IAM roles: `storage.objectCreator` (bucket), `bigquery.dataViewer` (dataset)
- Row access policy: `region_filter` (filters by region)

## How to run
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

Then add the row access policy:
```bash
bq query --use_legacy_sql=false \
'CREATE ROW ACCESS POLICY region_filter
ON `PROJECT_ID.d1_staged_enforced.student_onboarding`
GRANT TO ("user:YOUR_EMAIL")
FILTER USING (region = "US")'
```

## Notes
- No credentials or key files are stored in this repo — auth is handled via
  `gcloud auth application-default login`.
- `.terraform/` and `*.tfstate` are excluded via `.gitignore`.
