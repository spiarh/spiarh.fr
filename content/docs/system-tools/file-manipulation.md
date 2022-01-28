---
title: "file manipulation"
linkTitle: "file manipulation"
date: 2017-01-05
---

## sed

### remove color codes (special characters)

```bash
sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"

kubectl cluster-info|sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"|grep "Kubernetes master is running"
```

### print uncommented lines

```bash
sed '/^#/d' squid.conf
```

### remove empty lines

```bash
sed '/^ *$/d' squid.conf
```

### print uncommented lines and remove empty lines

```bash
sed '/^#/d;/^ *$/d' squid.conf
```

### replace in file

```bash
sed -i 's/foo/bar/g' file
```

### print specific line

```bash
$ sed -n 1p somefile.txt
```

## cat

* redirect content into a file:

```bash
cat << EOF > /tmp/file
CONTENT
EOF
```

## tee

### no variable substitution

```bash
cat << 'EOF' | tee /tmp/file
The variable $VARIABLE will *not* be interpreted.
EOF
```

### variable substitution

```bash
cat << "EOF" | tee /tmp/file
The variable $VARIABLE will be interpreted.
EOF
```

### variable substitution, leading tab retained, overwrite file, echo to stdout

```bash
tee /tmp/file <<EOF
$VARIABLE
EOF
```

### no variable substitution, leading tab retained, overwrite file, echo to stdout

```bash
tee /tmp/file <<'EOF'
$VARIABLE
EOF
```

### variable substitution, leading tab removed, overwrite file, echo to stdout

```bash
tee /tmp/file <<-EOF
    $VARIABLE
EOF
```

### variable substitution, leading tab retained, append to file, echo to stdout

```bash
tee -a /tmp/file <<EOF
$VARIABLE
EOF
```

### variable substitution, leading tab retained, overwrite file, no echo to stdout

```bash
tee /tmp/file <<EOF >/dev/null
$VARIABLE
EOF
```

### the above can be combined with sudo as well

```bash
sudo -u USER tee /tmp/file <<EOF
$VARIABLE
EOF
```

## find

### rename files to remove .apply

```bash
find . -name '*.apply' | xargs -r -n1 -i sh -c ' mv {} $(echo "{}" |sed 's/\.apply//g')'
```

### search all files in path and run sed

```bash
find . -type f -exec sed -i 's/foo/bar/g' {} +
```

### ignore hidden files (such as .git), pass the negation modifier -not -path '*/\.*':

```bash
find . -type f -not -path '*/\.*' -exec sed -i 's/foo/bar/g' {} +
```

### limit to markdown/go files

```bash
find . -type f -name "*.md" -exec sed -i 's/foo/bar/g' {} +
```

```bash
find . -name "*.go" -exec sed -i '' s/package pod/package resources/g {} \;
```

### case insensitive

```
find . -not -path 'vendor' -iname '*helm*'
```

### conditions or/and

All files outside the vendor path with helm
in path or in the file name.

```bash
find . -not -path '*vendor*' -a -iname '*helm*' -o -ipath '*helm*' -a -not -path '*vendor*'
```

## xargs

### use outputs as arguments for a command

```bash
kubectl get pv | awk '/ceph/ {print $1}' | xargs -I{} kubectl delete pv {}
govc ls /PROVO/vm | grep lcavajani-worker | xargs -r -n1 govc vm.destroy
```

### cat on all files in the dir

```bash
find ./ -name 'kustomization.yaml'| xargs -r -n1 cat
```

### sed on all files in the dir

```bash
find ./ -type f | xargs -r -n1 -i sed -i 's|foo|bar|g' {}
```

### count values and sort

```bash
cat access.log | cut -d " " -f 1 | sort | uniq -c | sort -urn
```
