# habot_connectcd ~/habot_connect

cat > README.md << 'EOF'
# HabotConnect Hiring Project — Junior Cloud & DevOps Engineer

**Submitted by:** Atharva Topre
**Contact:** atharva.topre116@gmail.com

---

## Task 1: Terraform Secure Staging Provisioning
**Location:** `terraform/main.tf`

Provisions a GCS bucket (D0 raw landing) and a BigQuery dataset + table
(D1 staged/enforced) with least-privilege IAM bindings and a row-level
security policy restricting read access by region.

---

## Task 2: Poka-Yoke Automated CI/CD Build Gate
**Location:** `.github/workflows/pipeline.yml`

A fail-closed GitHub Actions pipeline that runs linting and secret scanning
on every push. Demonstrated by intentionally committing a hardcoded API key
(build failed/red) then removing it (build passed/green).

See commit history and Actions tab for the red-to-green demonstration.

---

## Task 3: Schema Mapping and DCYN Validation
**Location:** `onboarding_app/serializers.py` and `data/sample_payload.json`

A Django REST Framework serializer that validates a student onboarding
JSON payload with strict binary (yes/no) rules on every field — no partial
matches, no placeholders. Sample payload provided for reference.

---

## Repo structure

\`\`\`
habot_connect/
├── terraform/              → Task 1
│   └── main.tf
├── .github/workflows/      → Task 2
│   └── pipeline.yml
├── onboarding_app/         → Task 3
│   ├── serializers.py
│   ├── utils.py
│   └── config.py
└── data/                   → Task 3
    └── sample_payload.json
\`\`\`
EOF

git add .
git commit -m "Update README with clear task-by-task breakdown"
git push origin main
