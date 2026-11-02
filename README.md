# GRC Engineering

Six compliance automation builds across five NIST 800-53 control families.

Same 5-part anatomy each time. Different control family each time.

---

## The pattern

Every build has the same shape:

| | |
|---|---|
| **Control** | Which NIST 800-53 control the build maps to |
| **Failure mode** | What a real misconfiguration looks like |
| **Check** | What catches the failure — scanner, policy, or config rule |
| **Evidence** | The artifact that proves the check ran and what it found |
| **Integration** | Where the evidence lives so it is continuous, not point-in-time |

The point of the repo is not any single build. It is that this anatomy holds
across six different control families — which means it can be applied to a
control I haven't worked with before.

---

## The builds

| # | Build | Control | Family | Tool |
|---|---|---|---|---|
| [1](build-01-s3-public-gate) | S3 public-access gate | SC-7 | Boundary Protection | Checkov |
| [2](build-02-cloudtrail-ci-gate) | CloudTrail CI gate | AU-2 | Audit Events | GitHub Actions |
| [3](build-03-iam-evidence) | IAM wildcard evidence | AC-3 | Access Enforcement | Python |
| [4](build-04-mfa-rego) | MFA Rego policy | IA-2 | Identification & Authentication | OPA / Rego |
| [5](build-05-config-rule) | Security Hub Config rule | SI-4 | System Monitoring | AWS Config |
| [6](build-06-graduate) | Graduate build | CM-6 | Configuration Settings | Checkov + AWS Config |

Each folder contains the working artifact (Terraform, Rego, Python, or workflow
YAML), a README explaining the anatomy and the worksheet answer, and the
evidence screenshots.

---

## Scope

These are demonstration builds against a sandbox AWS account. One control per
build, not a full program. The worksheet answer in each README explains the
reasoning behind the build — which is the part that transfers.

---

## Related

For the risk assessment, POA&M, and third-party risk framework — the document
side of the portfolio — see
[grc-risk-portfolio](https://github.com/YOUR-USERNAME/grc-risk-portfolio).

---

## License

MIT — see [LICENSE](LICENSE).
