---
title: "gpg"
linkTitle: "gpg"
date: 2017-01-05
---

### delete SSH key from agent

```bash
ssh-add -l
gpg --list-secret-keys --with-keygrip

gpg-connect-agent
> KEYINFO --ssh-list --ssh-fpr
S KEYINFO 4FBAFA26260147AC5FADC74691F2ACD8F93B7A3B D - - 1 P MD5:63:73:73:2f:fa:01:86:26:52:82:bd:82:af:16:bd:a8 - S
S KEYINFO BAEA93AC1E0B784891BF3F6A2EFDC99DD47EFE13 D - - - P MD5:f0:ab:26:81:dc:23:09:c9:d7:7a:1c:c9:36:0e:21:e3 - S

> delete_key 4FBAFA26260147AC5FADC74691F2ACD8F93B7A3B
OK
> delete_key BAEA93AC1E0B784891BF3F6A2EFDC99DD47EFE13
OK
```
