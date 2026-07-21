# Authentication Bypass Hunting Skill — 17 Test Cases

> Load when: auth bypass, login bypass, authentication, session management, password reset.

## 71. Password reset token prediction (medium)
Request password reset for a test account. Inspect the reset token. If predictable (sequential, timestamp-based, weak hash), forge tokens for other accounts.

## 72. Password reset link reuse (easy)
Use a password reset link. After successful reset, try the same link again. Report if token is invalidated or still valid.

## 73. Password reset link expiration (easy)
Request password reset and wait >24 hours. Try the expired link. Report if it still works or gives a meaningful error.

## 74. Auth bypass via response manipulation (medium)
After failed login, manipulate response: `{"success": false, "isAdmin": false}` → `{"success": true, "isAdmin": true}`. Report if server trusts client-side response.

## 75. Auth bypass via case sensitivity (easy)
Test login with email variations: `ADMIN@foo.com`, `Admin@Foo.com`, `admin@FOO.COM`. Report if case-insensitive comparison bypasses checks.

## 76. Auth bypass via null bytes (easy)
Add null bytes to username/password: `admin%00`, `admin\x00`. Report if null byte truncation bypasses validation.

## 77. Auth bypass via JSON type confusion (medium)
Send `{"username": ["admin"], "password": "pass"}` or `{"username": {"$ne": ""}}`. Report if type juggling bypasses checks.

## 78. Session fixation (medium)
Set session cookie before login. Login successfully. Report if same session ID persists or if new session is issued.

## 79. JWT alg:none bypass (easy)
If app uses JWT, decode token, change `alg` to `none`, remove signature. Submit. Report if accepted.

## 80. JWT key confusion (medium)
If app uses RS256, try forging JWT with HMAC using the public key (RS256→HS256 confusion).

## 81. Session token in URL (easy)
Check if session tokens appear in URLs, Referer headers, or log files. Report token leakage vectors.

## 82. Auth bypass via redirect (medium)
After login, check redirect URL. Try `?next=/admin`, `?returnUrl=/admin`. Report if authorization checks are skipped on redirected pages.

## 83. 2FA bypass (medium)
If 2FA is implemented, try: skip 2FA step entirely, brute force 6-digit code, bypass via API directly, replay old 2FA token.

## 84. Auth bypass via remember me (easy)
If "remember me" token is predictable or not invalidated on password change, forge or reuse tokens.

## 85. Auth bypass via API endpoint (medium)
If login form has CSRF protection, check if the underlying API endpoint accepts plain POST without CSRF token.

## 86. Brute force protection bypass (easy)
Test login with rapid attempts. Report if rate limiting, account lockout, or CAPTCHA is missing.

## 87. OAuth token leakage (hard)
Check OAuth redirect URIs. If `redirect_uri` is loosely validated, hijack tokens by redirecting to attacker domain.

---

## Common Auth Bypass Techniques
| Technique | Payload/Method |
|-----------|---------------|
| SQLi | `' OR '1'='1'--` |
| NoSQLi | `{"$ne": ""}` |
| JWT alg:none | Remove signature, set alg to none |
| JWT key confusion | Sign with public key as HMAC |
| Response manipulation | Proxy → modify JSON response |
| Type juggling | `true`, `1`, `[]`, `{}` |
| Null byte | `admin%00` |
| Case sensitivity | `Admin`, `ADMIN` |
| Path traversal | `/../admin`, `/admin/` |
