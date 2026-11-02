# Build 1: S3 public-access gate

A Terraform config declares an S3 bucket with `acl = "public-read"`. Checkov
catches it (rule CKV_AWS_20). I changed the ACL to `"private"`. The scan now
passes. Both scans are committed below — `diff scan-before.txt scan-after.txt`
shows the exact change.

One of six builds applying the same 5-part pattern with a different NIST
800-53 control each time.

## Anatomy

| Part | This build |
|---|---|
| **Control** | SC-7 — Boundary Protection (NIST 800-53) |
| **Failure mode** | S3 bucket with `acl = "public-read"` — anyone on the internet can read its contents |
| **Check** | Checkov rule CKV_AWS_20 |
| **Evidence** | `scan-before.txt` (CKV_AWS_20 FAILED) and `scan-after.txt` (CKV_AWS_20 PASSED) |
| **Integration** | Point-in-time scan committed to this repo. CI enforcement is Build 2. |

## Worksheet

**Question:** Where would an auditor look to verify this control exists
*continuously*, not just the day you ran the scan?

**Answer:** Nothing yet. The scan is point-in-time — a snapshot of the file
the moment I ran it. If the file changes tomorrow, the scan output on disk
doesn't know. There's no continuous evidence in this build.

**Reference:** Continuous evidence lives in a CI pipeline that re-runs the
check on every commit, or in AWS Config keeping a rule active regardless of
who's looking. A manual scan proves a moment; CI or Config proves a timeline.

## Scope

The scan surfaces 8 failures against this bucket, not just CKV_AWS_20. Each
maps to a different control family (AU-2, CP-9, SC-28, SC-7). This build
demonstrates one: the SC-7 public-ACL failure and its fix. The rest are
named and deferred, not missed.

## Evidence

- [`scan-before.txt`](scan-before.txt) — CKV_AWS_20 FAILED
- [`scan-after.txt`](scan-after.txt) — CKV_AWS_20 PASSED

## The fix

```diff
 resource "aws_s3_bucket" "demo" {
   bucket = "demo-test-bucket"
-  acl    = "public-read"
+  acl    = "private"
 }
