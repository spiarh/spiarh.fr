---
title: "tcpdump"
linkTitle: "tcpdump"
date: 2017-01-05
---

### filtering with unix tools

Read the file and filter to find the destination IP with the most hits.

```bash
$ curl -OL https://www.offensive-security.com/pwk-online/password_cracking_filtered.pcap

$ tcpdump -r password_cracking_filtered.pcap
08:51:20.800917 IP 208.68.234.99.60509 > 172.16.40.10.81: Flags [S], seq 1855084074, win 14600, options [mss 1460,sackOK,TS val 25538253 ecr 0,nop,wscale 7], length 0
08:51:20.800953 IP 172.16.40.10.81 > 208.68.234.99.60509: Flags [S.], seq 4166855389, ack 1855084075, win 14480, options [mss 1460,sackOK,TS val 71430591 ecr 25538253,nop,wscale 4], length 0
08:51:20.801023 IP 208.68.234.99.60509 > 172.16.40.10.81: Flags [S], seq 1855084074, win 14600, options [mss 1460,sackOK,TS val 25538253 ecr 0,nop,wscale 7], length 0
08:51:20.801030 IP 172.16.40.10.81 > 208.68.234.99.60509: Flags [S.], seq 4166855389, ack 1855084075, win 14480, options [mss 1460,sackOK,TS val 71430591 ecr 25538253,nop,wscale 4], length 0
08:51:20.801048 IP 208.68.234.99.60509 > 172.16.40.10.81: Flags [S], seq 1855084074, win 14600, options [mss 1460,sackOK,TS val 25538253 ecr 0,nop,wscale 7], length 0
08:51:20.801051 IP 172.16.40.10.81 > 208.68.234.99.60509: Flags [S.], seq 4166855389, ack 1855084075, win 14480, options [mss 1460,sackOK,TS val 71430591 ecr 25538253,nop,wscale 4], length 0
08:51:20.802026 IP 208.68.234.99.60509 > 172.16.40.10.81: Flags [.], ack 1, win 115, options [nop,nop,TS val 25538253 ecr 71430591], length 0
08:51:20.802032 IP 208.68.234.99.60509 > 172.16.40.10.81: Flags [P.], seq 1:89, ack 1, win 115, options [nop,nop,TS val 25538253 ecr 71430591], length 88
08:51:20.802053 IP 172.16.40.10.81 > 208.68.234.99.60509: Flags [.], ack 89, win 905, options [nop,nop,TS val 71430591 ecr 25538253], length 0
08:51:20.802105 IP 208.68.234.99.60509 > 172.16.40.10.81: Flags [.], ack 1, win 115, options [nop,nop,TS val 25538253 ecr 71430591], length 0
[...]

$ tcpdump -n -r password_cracking_filtered.pcap | awk -F" " '{print $5}' | sort | uniq -c | head
  20164 172.16.40.10.81:
     14 208.68.234.99.32768:
     14 208.68.234.99.32769:
      6 208.68.234.99.32770:
     14 208.68.234.99.32771:
      6 208.68.234.99.32772:
      6 208.68.234.99.32773:
     15 208.68.234.99.32774:
     12 208.68.234.99.32775:
      6 208.68.234.99.32776:
```

### with flags

```bash
$ tcpdump -n src host 172.16.40.10 -r password_cracking_filtered.pcap
$ tcpdump -n dst host 172.16.40.10 -r password_cracking_filtered.pcap
$ tcpdump -n port 81 -r password_cracking_filtered.pcap
```

### dump captured traffic

```bash
$ tcpdump -nX -r password_cracking_filtered.pcap
08:51:25.043062 IP 208.68.234.99.33313 > 172.16.40.10.81: Flags [P.], seq 1:140, ack 1
  0x0000:  4500 00bf 158c 4000 3906 9cea d044 ea63  E.....@.9....D.c
  0x0010:  ac10 280a 8221 0051 a726 a77c 6fd8 ee8a  ..(..!.Q.&.|o...
  0x0020:  8018 0073 1c76 0000 0101 080a 0185 b2f2  ...s.v..........
  0x0030:  0441 f5e3 4745 5420 2f2f 6164 6d69 6e20  .A..GET.//admin.
  0x0040:  4854 5450 2f31 2e31 0d0a 486f 7374 3a20  HTTP/1.1..Host:.
  0x0050:  6164 6d69 6e2e 6d65 6761 636f 7270 6f6e  admin.megacorpon
  0x0060:  652e 636f 6d3a 3831 0d0a 5573 6572 2d41  e.com:81..User-A
  0x0070:  6765 6e74 3a20 5465 6820 466f 7265 7374  gent:.Teh.Forest
  0x0080:  204c 6f62 7374 6572 0d0a 4175 7468 6f72  .Lobster..Author
  0x0090:  697a 6174 696f 6e3a 2042 6173 6963 2059  ization:.Basic.Y
  0x00a0:  5752 7461 5734 3662 6d46 7562 3352 6c59  WRtaW46bmFub3RlY
  0x00b0:  3268 7562 3278 765a 336b 780d 0a0d 0a    2hub2xvZ3kx....
```

### advanced header filtering

Look for packets that have the PSH and ACK flags turned on. All packets sent and received after the initial 3-way handshake will have the ACK flag set. The PSH flag1 is used to enforce immediate delivery of a packet and is commonly used in interactive Application Layer protocols to avoid buffering.

Looking at the TCP Header diagramm, we can see that ACK and PSH are represented
by the fourth and fifth bits of the 14th byte, respectively:

```
CEUAPRSF
WCRCSSYI
REGKHTNN
00011000  = 24 in decimal
```

Turning on only these bits would give us 00011000, or decimal 24.

```bash
$ echo "$((2#00011000))"
24
```

We can pass this number to tcpdump with 'tcp[13] = 24' as a display filter to indicate that we only want to see packets with the ACK and PSH bits set ("data packets") as represented by the fourth and fifth bits (24) of the 14th byte of the TCP header. Bear in mind, the tcpdump array index used for counting the bytes starts at zero, so the syntax should be (tcp[13]).

The combination of these two flags will hopefully show us only the HTTP requests and responses data. Here's the command we'll use to display packets that have the ACK or PSH flags set:

```bash
tcpdump -A -n 'tcp[13] = 24' -r password_cracking_filtered.pcap
```
