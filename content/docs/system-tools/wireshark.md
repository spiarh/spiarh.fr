---
title: "tcpdump/wireshark"
linkTitle: "tcpdump & wireshark"
date: 2017-01-05
---

### filters

EHLO withing a timeframe:

```
smtp.command_line == "EHLO bugzilla.example.com\x0d\x0a" && (frame.time >= "Aug 03, 2021 19:33:25") &&  (frame.time <= "Aug 03, 2021 19:33:27")
```

Only new connections:

```
tcp.flags.syn==1 && tcp.flags.ack==0
```

Some port:

```
tcp.port==8080
```
