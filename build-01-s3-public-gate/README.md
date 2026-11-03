# Build 1: S3 Public-Access Gate

This terraform config contained rules for an S3 bucket reading 'acl = "public-read"'.
Checkov catches it with rule CKV_AWS_20. I changed the ACL from public-read to private.
The scan now passes. Both scans have been committed and show the change made.

This is one of six builds applying the same 5-step pattern to different NIST 800-53 controls.

## Anatomy

| Part | This build |
|---|---|
| **Control** | SC-7 — Boundary Protection (NIST 800-53) |
| **Failure mode** | S3 bucket with `acl = "public-read"`. This allows anyone on the internet to read the bucket's contents. |
| **Check** | Checkov rule CKV_AWS_20 |
| **Evidence** | `scan-before.txt` (CKV_AWS_20 FAILED) and `scan-after.txt` (CKV_AWS_20 PASSED) |
| **Integration** | None. This is a point-in-time snapshot and does not prevent further change. |

## Worksheet

**Question:** Where would an auditor look to verify this control exists
*continuously*, not just the day you ran the scan?

**Answer:** Nowhere. This is a point-in-time scan, a snapshot of the file the 
moment Checkov was run. If the file is changed, the only way to know is to run the
scan again manually. There is no continuous scanning evidence.

**Reference:** Continuous evidence lives in a CI pipeline that re-runs the check
on every commit, or in AWS Config keeping a rule active regardless of who's looking.
Neither mechanism exists in this build - the scan is manual, the evidence is
committed text files, and nothing re-runs automatically. Build 2 introduces the
CI pipeline; Build 5 introduces the Config rule.



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
