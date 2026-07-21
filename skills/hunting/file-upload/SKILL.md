# File Upload Vulnerability Hunting Skill — 12 Test Cases

> Load when: file upload, upload bypass, webshell, unrestricted upload.

## 98. Unrestricted file upload (easy)
Upload `.php`, `.jsp`, `.asp`, `.sh` files. If accepted, report RCE vector.

## 99. Extension bypass (medium)
Try: `shell.php.jpg`, `shell.php%00.jpg`, `shell.pHp`, `shell.php5`, `shell.phtml`. Report bypasses.

## 100. Content-Type bypass (easy)
Change Content-Type to `image/jpeg` while uploading PHP. Report if only Content-Type is checked.

## 101. Double extension bypass (medium)
Try: `shell.php.jpg`, `shell.php.png`, `shell.jpg.php`. Report if parser confusion occurs.

## 102. Path traversal in filename (medium)
Upload file named `../../../etc/cron.d/shell`. Report if path traversal in filename is possible.

## 103. SVG XSS upload (easy)
Upload SVG with `<script>alert(1)</script>`. Report if SVG is served inline.

## 104. SVG XXE upload (medium)
Upload SVG with `<!ENTITY xxe SYSTEM "file:///etc/passwd">`. Report if entities are processed.

## 105. ZIP slip (hard)
Upload ZIP with `../../etc/cron.d/shell` entry. Report if extraction writes outside directory.

## 106. ImageMagick exploit (hard)
Upload crafted image that triggers ImageMagick command execution (ImageTragick).

## 107. EXIF metadata injection (easy)
Upload image with malicious EXIF metadata (GPS, comments). Check if metadata is stored and rendered.

## 108. File content validation bypass (medium)
Prepend magic bytes (`FF D8 FF E0` for JPEG) to PHP file. Report if only magic bytes are checked.

## 109. Filename XSS (easy)
Upload file named `"><img src=x onerror=alert(1)>.jpg`. Check if filename is reflected in HTML.

---

## Upload Bypass Techniques
| Technique | Payload |
|-----------|---------|
| Null byte | `shell.php%00.jpg` |
| Double extension | `shell.php.jpg` |
| Case variation | `shell.pHp` |
| Alternative extension | `shell.phtml` |
| Magic bytes | Prepend `FF D8 FF E0` |
| Path traversal | `../../../shell.php` |
| Right-to-left override | `shell.php\u202E` |
