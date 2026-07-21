# Cloud / AWS Security Testing Skill — 8 Test Cases

> Load when: cloud, AWS, GCP, Azure, S3, metadata, IAM, secrets.

## 214. S3 bucket enumeration (easy)
Check for publicly accessible S3 buckets: `curl https://bucket-name.s3.amazonaws.com/`. Report open buckets.

## 215. S3 bucket listing (easy)
If bucket allows listing: `curl https://bucket-name.s3.amazonaws.com/?list-type=2`. Report sensitive files.

## 216. Cloud metadata SSRF (hard)
Use SSRF to access `http://169.254.169.254/latest/meta-data/iam/security-credentials/`. Report leaked IAM credentials.

## 217. AWS credentials in environment (medium)
If code execution is possible, check environment variables: `env | grep AWS`. Report leaked access keys.

## 218. Azure blob storage (medium)
Check for publicly accessible Azure blobs: `https://account.blob.core.windows.net/container?restype=container&comp=list`.

## 219. GCP bucket enumeration (medium)
Check for publicly accessible GCS buckets: `https://storage.googleapis.com/storage/v1/b/bucket/o`.

## 220. IAM privilege escalation (hard)
If AWS credentials are found, enumerate permissions: `aws iam list-attached-user-policies`. Report escalation paths.

## 221. Secrets in cloud config (medium)
Check for secrets in Terraform state, CloudFormation templates, Kubernetes secrets, Docker configs.

---

## Cloud Metadata Endpoints
| Provider | Endpoint |
|----------|----------|
| AWS IMDSv1 | `http://169.254.169.254/latest/meta-data/` |
| AWS IMDSv2 | PUT `http://169.254.169.254/latest/api/token` |
| GCP | `http://metadata.google.internal/computeMetadata/v1/` |
| Azure | `http://169.254.169.254/metadata/instance?api-version=2021-02-01` |
