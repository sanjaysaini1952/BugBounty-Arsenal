# Mobile Application Testing Skill — 6 Test Cases

> Load when: mobile, Android, iOS, APK, IPA, mobile API, certificate pinning.

## 208. APK reverse engineering (medium)
Decompile APK with jadx. Search for hardcoded API keys, secrets, debug flags, admin endpoints, test credentials.

## 209. Certificate pinning bypass (medium)
If app uses cert pinning, test with Frida: `ssl_unpinning.js`, objection, or Burp with CA cert installed.

## 210. Insecure data storage (easy)
Check SharedPreferences (Android) or Keychain (iOS) for sensitive data stored in plaintext.

## 211. Mobile API testing (medium)
Intercept mobile app traffic with proxy. Test API endpoints for IDOR, auth bypass, mass assignment.

## 212. Deep link / URL scheme testing (medium)
Test custom URL schemes for open redirect, auth bypass, or injection: `myapp://admin/delete?id=1`.

## 213. Root/jailbreak detection bypass (medium)
If app checks for root/jailbreak, bypass with Frida scripts or objection.

---

## Mobile Testing Checklist
- [ ] Decompile and review source code
- [ ] Check for hardcoded secrets
- [ ] Test API endpoints via proxy
- [ ] Check data storage (SharedPreferences/Keychain)
- [ ] Test certificate pinning
- [ ] Test deep links / URL schemes
- [ ] Check for debug flags
- [ ] Test backup settings
