---
title: "dd"
linkTitle: "dd"
date: 2017-01-05
---


### Run a quick "benchmark"

This is absolutely not a real benchmark but it can gives some hints
bout the storage performance.

This tells dd to require a complete “sync” once, right before it exits.
So it commits the whole 800MB of data, then tells the operating system to
ensure this is completely on disk, only then measures the total time
it took to do all that and calculates the benchmark result.


```bash
# dd if=/dev/zero of=/tmp/output bs=8k count=100k conv=fdatasync; rm -f /tmp/output
102400+0 records in
102400+0 records out
838860800 bytes (839 MB, 800 MiB) copied, 1.76411 s, 476 MB/s
```

This tells dd to ask for completely synchronous output to disk, ensure that
its write requests don’t even return until the submitted data is on disk.
In the above example, this will mean sync’ing once per megabyte. It would
probably be the slowest mode, as the write cache is basically unused at all in this case.

```bash
# dd if=/dev/zero of=/tmp/output bs=8k count=100k oflag=dsync; rm -f /tmp/output
```

### Copy ISO to USB stick

```bash
dd status=progress if=Fedora-Workstation-Live-x86_64-32-1.6.iso of=/dev/sdc
```
