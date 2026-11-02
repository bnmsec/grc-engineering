# grc-engineering

Six compliance automation builds. Each maps a NIST 800-53 control to a working
artifact — policy-as-code, CI gate, or evidence pipeline. Every build follows
the same 5-part shape:

**Control → Failure mode → Check → Evidence → Integration**

Different control family each time, to show the pattern transfers.

## Builds

| # | Build | Control | Family | Tool | Status |
|---|---|---|---|---|---|
| [1](build-01-s3-public-gate) | S3 public-access gate | SC-7 | Boundary Protection | Checkov | shipped |
| 2 | CloudTrail CI gate | AU-2 | Audit Events | GitHub Actions | planned |
| 3 | IAM wildcard evidence | AC-3 | Access Enforcement | Python | planned |
| 4 | MFA Rego policy | IA-2 | Identification & Authentication | OPA / Rego | planned |
| 5 | Security Hub Config rule | SI-4 | System Monitoring | AWS Config | planned |
| 6 | Graduate build | CM-6 | Configuration Settings | Checkov + Config | planned |

Each shipped row links to a folder containing the working artifact, a README
with the 5-part anatomy filled in for that build, and the evidence files.

## Related

[grc-risk-portfolio](https://github.com/bnmsec/grc-risk-portfolio) — risk
assessment, POA&M, and third-party risk framework.
