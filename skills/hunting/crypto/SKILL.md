# Cryptography Testing Skill — 6 Test Cases

> Load when: cryptography, weak crypto, hash length extension, padding oracle.

## 222. Weak hashing algorithms (easy)
Check if app uses MD5 or SHA1 for password hashing or sensitive data. Report weak algorithm usage.

## 223. Predictable tokens (medium)
If tokens are generated using timestamps or sequential values, predict next token. Report predictability.

## 224. Hash length extension attack (hard)
If app uses `MD5(secret + data)`, inject additional data using hash length extension. Report auth bypass.

## 225. Padding oracle attack (hard)
If app uses CBC mode encryption and reveals padding validity, use padding oracle to decrypt ciphertext.

## 226. Insecure random number generation (medium)
Check if app uses `Math.random()`, `rand()`, `random()` for security-sensitive operations. Report predictability.

## 227. TLS misconfiguration (medium)
Test TLS configuration: weak ciphers, expired certificates, missing HSTS, SSLv3 support.

---

## Weak Algorithm Detection
| Algorithm | Status | Action |
|-----------|--------|--------|
| MD5 | Broken | Report |
| SHA1 | Deprecated | Report |
| DES | Weak | Report |
| 3DES | Deprecated | Report |
| RC4 | Broken | Report |
| AES-256-GCM | Secure | OK |
| RSA-2048+ | Acceptable | Check padding |
| Ed25519 | Secure | OK |
