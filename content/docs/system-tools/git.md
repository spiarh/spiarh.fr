---
title: "git"
linkTitle: "git"
date: 2017-01-05
---

### show diff staged

```bash
git diff --staged
git diff --cached
```

### edit last commit

```bash
git commit --amend
```

### remove last commit without touching the files

```bash
git reset --soft HEAD~1
```

### grep in commits

Find commits that introduce or remove lines containing a given regexp.

```bash
git log -p -G "MAX_REGISTERED_USERS"
```

To just see the change, add `--color-words`.

To show all the changes in that changeset, use `--pickaxe-all`

To look for differences that change the number of occurrences
of the specified string (i.e. addition/deletion),
use `-S` instead of `-G`.

### add upstream repo

```bash
git remote add upstream [UPSTREAM-GIT-URL]
git fetch upstream
```

### get logs specific file

```bash
git log --follow -p -- defaults/main.yml
```

#### checkout pull request

Fetch the ID of the PR and create a new branch from it:

```bash
BRANCHNAME=PR-1012
ID=1012

git fetch upstream pull/$ID/head:$BRANCHNAME
git fetch origin pull/$ID/head:$BRANCHNAME
```

Switch to the new branch:

```bash
git checkout $BRANCHNAME
> Switched to a new branch '$BRANCHNAME'
```

### show contributors

```bash
git shortlog -s -n
```

### list tracking branches

```bash
git getch
git branch -a
```

### list remote branches

```bash
git ls-remote
```

### delete remote branch

```bash
git push -d origin remove_branch
```

## dotfiles

This allows to store the important files in $HOME using
the `dotfiles` alias.

### init repository

```bash
mkdir -p $HOME/.dotfiles
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles {add,commit,status}
```

### restore repository

```bash
git clone --bare https://git/repo/dotfiles.git $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
```

### disable TLS verification

change in the global config:

```bash
git config --global http.sslVerify false
```

or with env var:

```bash
GIT_SSL_NO_VERIFY=true git clone
```

### TLS Options

```
http.sslVerify
    Whether to verify the SSL certificate when fetching or pushing over HTTPS.
    Can be overridden by the GIT_SSL_NO_VERIFY environment variable.

http.sslCAInfo
    File containing the certificates to verify the peer with when fetching or pushing
    over HTTPS. Can be overridden by the GIT_SSL_CAINFO environment variable.

http.sslCAPath
    Path containing files with the CA certificates to verify the peer with when
    fetching or pushing over HTTPS.
    Can be overridden by the GIT_SSL_CAPATH environment variable.
```
