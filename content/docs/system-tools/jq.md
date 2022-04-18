---
title: "jq"
linkTitle: "jq"
date: 2017-01-05
---

### get all pods with a specific env var

Also filter the namespaces to start with `app`

```bash
kubectl get po -A -ojson | jq '.items[] | select((.spec.containers[].env[]? | .name) == "OTEL_EXPORTER_JAEGER_ENDPOINT") | {namespace: .metadata.namespace, name: .metadata.name} | select(.namespace | match("^app.*"))'
```

### get all the CVEs for a jenkins version

Get all the CVEs for Jenkins

```bash
curl -L  https://cvepremium.circl.lu/api/search/jenkins/jenkins > jenkins.json
```

Filter on a specific version

```bash
cat jenkins.json | jq '[.results[] | select(.vulnerable_product != null) | select(([.vulnerable_product] | tostring) | match(".*2.164.3.*"; "i"))]' > jenkins-2.164.3.json
```

Remove some lengthy keys:

```bash
cat jenkins-2.164.3.json | jq '[.[] | del(.vulnerable_configuration, .vulnerable_product)]' > jenkins.cve_clean.json
```

Filter to a few set of keys:

```bash
$ cat jenkins.cve_clean.json | jq '[.[] | {id : .id, cvss3: .cvss3, impactScore3: .impactScore3, exploitabilityScore3: .exploitabilityScore3, summary: .summary}] | sort_by(.cvss3)'
[
  {
    "id": "CVE-2021-21694",
    "cvss3": 9.8,
    "impactScore3": 5.9,
    "exploitabilityScore3": 3.9,
    "summary": "FilePath#toURI, FilePath#hasSymlink, FilePath#absolutize, FilePath#isDescendant, and FilePath#get*DiskSpace do not check any permissions in Jenkins 2.318 and earlier, LTS 2.303.2 and earlier.",
    "references": "[\"https://www.jenkins.io/security/advisory/2021-11-04/#SECURITY-2455\"]"
  },
  {
    "id": "CVE-2021-21691",
    "cvss3": 9.8,
    "impactScore3": 5.9,
    "exploitabilityScore3": 3.9,
    "summary": "Creating symbolic links is possible without the 'symlink' agent-to-controller access control permission in Jenkins 2.318 and earlier, LTS 2.303.2 and earlier.",
    "references": "[\"https://www.jenkins.io/security/advisory/2021-11-04/#SECURITY-2455\"]"
  }
]
```

Generate TSV:

```bash
$ cat jenkins.cve_clean.json | jq -r '[.[] | {id : .id, cvss3: .cvss3, impactScore3: .impactScore3, exploitabilityScore3: .exploitabilityScore3, summary: .summary, references: (.references | tostring)}] | sort_by(.cvss3) | (map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @tsv'

9.8	3.9	CVE-2021-21694	5.9	["https://www.jenkins.io/security/advisory/2021-11-04/#SECURITY-2455"]	FilePath#toURI, FilePath#hasSymlink, FilePath#absolutize, FilePath#isDescendant, and FilePath#get*DiskSpace do not check any permissions in Jenkins 2.318 and earlier, LTS 2.303.2 and earlier.
9.8	3.9	CVE-2021-21691	5.9	["https://www.jenkins.io/security/advisory/2021-11-04/#SECURITY-2455"]	Creating symbolic links is possible without the 'symlink' agent-to-controller access control permission in Jenkins 2.318 and earlier, LTS 2.303.2 and earlier.
```

