# GRC Engineering

Six compliance automation builds. Each maps a NIST 800-53 control to a working
pipeline artifact — policy-as-code, CI gates, and automated evidence emission.

The point isn't any single build. It's that the same 5-part anatomy transfers
across six different control families.

## Why this exists

Most GRC work is attestation: proving *after the fact* that a control exists,
via screenshots and Excel. This repo is the other half — encoding the control
as code so that evidence is generated as a byproduct of the pipeline, not
reconstructed for an audit.

## The pattern

Every build has the same 5-part anatomy:

1. **Control** — which NIST 800-53 control this build maps to
2. **Failure mode** — what a misconfiguration looks like in practice
3. **Check** — what catches the failure (a scanner, a policy, a config rule)
4. **Evidence** — what artifact proves the check ran and what it found
5. **Integration** — where the evidence lives so it is *continuous*, not point-in-time

## The builds

| # | Build | Control | Family | Tool | Status |
|---|---|---|---|---|---|
| 1 | S3 public-access gate | SC-7 | Boundary Protection | Checkov | shipped |
| 2 | CloudTrail CI gate | AU-2 | Audit Events | GitHub Actions | in progress |
| 3 | IAM wildcard evidence | AC-3 | Access Enforcement | Python | planned |
| 4 | MFA Rego policy | IA-2 | Identification & Authentication | OPA/Rego | planned |
| 5 | Security Hub Config rule | SI-4 | System Monitoring | AWS Config | planned |
| 6 | Graduate build | *your pick* | *your pick* | *your pick* | planned |

Click any build folder for the anatomy, the worksheet answer, and the evidence.

## What this proves

- **Same pattern, different domains.** Build 1 and Build 5 share almost no
  tooling but share the same anatomy. That transfer is the point — it means
  the pattern can be applied to a control I haven't seen before.
- **Built artifacts, not documentation.** Each build has a public repo folder
  with code and evidence. Nothing here is a screenshot of a slide.
- **Continuous where it can be.** CI gates and Config rules generate evidence
  on a schedule; manual scans are noted as point-in-time.

## What this doesn't prove

These are demonstration builds against a sandbox AWS account, not production
deployments. The scope is a single control per build, not a full program.
The worksheet question for each build is deliberately answered — that's the
reasoning, and the reasoning is what's being tested here.

## Related

For the risk assessment, POA&M, and third-party risk framework — the
document-and-analysis side of the portfolio — see
[grc-risk-portfolio](https://github.com/YOUR-USERNAME/grc-risk-portfolio).

## Verify it works

```bash
git clone https://github.com/YOUR-USERNAME/grc-engineering.git
cd grc-engineering/build-01-s3-public-gate
pip install checkov
checkov -f main.tf --framework terraform
