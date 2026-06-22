# Exercise 26: S3 Backup Solution

## Objective

Implement a backup strategy for:

- Application Files
- Configuration Files

and store backups in Amazon S3.

Additionally, demonstrate the restore process.

---

## Architecture

Application Files
+
Config Files
|
v
Backup Script
|
v
Compressed Archive (.tar.gz)
|
v
Amazon S3 Bucket
|
v
Restore Process
|
v
Recovered Files

---

## Environment

- AWS S3
- AWS CLI
- Linux
- Bash

---

## Project Structure

```
26-s3-backup-solution/
│
├── app/
│   └── app.py
│
├── config/
│   └── config.yaml
│
├── backup.sh
│
├── backup-2026-06-22.tar.gz
│
└── screenshots/
```

---

## S3 Bucket Creation

```bash
aws s3 mb s3://ajay-backup-demo-2026-12345 --region us-east-1
```

Verify:

```bash
aws s3 ls
```

---

## Application File

```python
print("Backup Demo Application")
```

---

## Configuration File

```yaml
application:
  name: backup-demo

environment:
  dev
```

---

## Backup Script

```bash
#!/bin/bash

DATE=$(date +%F)

tar -czf backup-$DATE.tar.gz app config

aws s3 cp backup-$DATE.tar.gz \
s3://ajay-backup-demo-2026-12345/
```

---

## Execute Backup

```bash
chmod +x backup.sh

./backup.sh
```

---

## Verify Backup

```bash
aws s3 ls s3://ajay-backup-demo-2026-12345
```

Example:

```text
backup-2026-06-22.tar.gz
```

---

## Disaster Simulation

Delete application and configuration files:

```bash
rm -rf app config
```

---

## Restore Process

Download backup:

```bash
aws s3 cp \
s3://ajay-backup-demo-2026-12345/backup-2026-06-22.tar.gz .
```

Extract backup:

```bash
tar -xzf backup-2026-06-22.tar.gz
```

---

## Verify Restore

```bash
tree
```

Expected:

```text
app/
config/
backup.sh
backup-2026-06-22.tar.gz
```

Verify contents:

```bash
cat app/app.py

cat config/config.yaml
```

---

## Validation

### Backup

- Application files uploaded to S3
- Configuration files uploaded to S3

### Restore

- Files downloaded from S3
- Files restored successfully
- File contents verified

---

## Outcome

Successfully implemented an S3-based backup and restore solution.

Features:

- Backup Application Files ✅
- Backup Configuration Files ✅
- Store Backup in Amazon S3 ✅
- Restore From Amazon S3 ✅
- Restore Verification ✅

Exercise 26 Completed Successfully.
