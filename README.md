# krb-faketime ⏱️
## About

`kerbtime` is a small Bash wrapper that automates Kerberos clock-skew bypassing for Impacket-based tooling using `faketime`. </br>
Kerberos authentication is extremely sensitive to time drift. When attacking misconfigured or lab environments, a desynchronized clock between the attacker and the Domain Controller often results in: `Kerberos SessionError: KRB_AP_ERR_SKEW(Clock skew too great)` </br>
</br>
This tool brute-forces hour offsets transparently until the skew is resolved.

## Features

- Works with **any Impacket command**
- Automatically prefixes the command with `faketime`
- Iterates through hour offsets (`+1h`, `+2h`, …)
- Stops immediately when the Kerberos skew error disappears and prints out full stdout/stderr of the successful execution

## Installation

```bash
$ git clone https://github.com/YounesTasra-R4z3rSw0rd/krb-faketime.git
$ cd krb-faketime
$ chmod +x krbtime.sh
```

## Usage example while proxychaining

```bash
$ ./kerbtime.sh proxychains -q impacket-GetUserSPNs -dc-ip 172.16.1.15 -request-user svc_sql domain.local/websec:Password123!
```
