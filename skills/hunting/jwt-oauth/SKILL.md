# JWT / OAuth Security Testing Skill — 8+8 Test Cases

> Load when: JWT, OAuth, SSO, token security, authentication.

## 172. JWT alg:none attack (easy)
Decode JWT, change `"alg": "RS256"` to `"alg": "none"`, remove signature. Submit token. Report if accepted.

## 173. JWT key confusion (medium)
If app uses RS256, sign token with HMAC using public key. Report if accepted.

## 174. JWT secret brute force (medium)
If JWT uses HS256 with weak secret, brute force with common passwords. Use jwt_tool.

## 175. JWT expired token acceptance (easy)
Use expired JWT token. Report if expiration is validated.

## 176. JWT claim manipulation (medium)
Modify `sub`, `role`, `isAdmin`, `exp` claims in JWT. Report if modifications are accepted.

## 177. JWT kid injection (medium)
If JWT has `"kid"` parameter, inject: `{"kid": "/dev/null"}` or `{"kid": "../../dev/null"}`. Report path traversal in key lookup.

## 178. JWT jwk/jku confusion (hard)
If app validates JWT via embedded JWK or JWKS URL, inject attacker's public key or URL.

## 179. JWT none algorithm + key confusion combined (hard)
Combine alg:none bypass with claim manipulation for full auth bypass.

## 180. OAuth redirect_uri open redirect (hard)
If OAuth validates redirect_uri loosely, test subdomain tricks, path traversal, URL parser confusion.

## 181. OAuth state parameter missing (medium)
Remove `state` parameter from OAuth flow. Report CSRF vulnerability.

## 182. OAuth token leakage via referrer (medium)
Check if OAuth tokens appear in URLs that get sent via Referer header.

## 183. OAuth token leakage via logs (medium)
Check if access tokens appear in server logs, CDN logs, analytics.

## 184. OAuth scope escalation (medium)
Request elevated scopes beyond what app needs. Report if excessive scopes are granted.

## 185. OAuth token replay (medium)
Use OAuth refresh token after it should be invalidated (password change, logout).

## 186. OAuth PKCE bypass (hard)
If app uses PKCE, test if code_verifier check is enforced or can be bypassed.

## 187. OAuth token in fragment (easy)
Check if tokens are passed in URL fragment (`#access_token=`). If so, report if JavaScript can access them.

## 188. OAuth impersonation via client credentials (hard)
If app uses client_credentials grant, check if client secret is exposed in frontend code.

## 189. OAuth token theft via mixed content (hard)
If OAuth callback page loads HTTP resources, attacker can intercept tokens via MITM.

---

## JWT Attack Reference
| Attack | Payload/Method |
|--------|---------------|
| alg:none | Remove signature, set alg to none |
| Key confusion | Sign with public key as HMAC |
| Secret brute force | Use jwt_tool with wordlist |
| Claim manipulation | Modify sub, role, isAdmin |
| kid injection | `{"kid": "/dev/null"}` |
| jwk injection | Embed attacker's public key |
| jku hijack | Point JWKS URL to attacker |

## OAuth Security Checklist
- [ ] `state` parameter validated
- [ ] `redirect_uri` strictly validated
- [ ] Tokens not in URL (use PKCE)
- [ ] Scopes follow principle of least privilege
- [ ] Tokens short-lived with refresh rotation
- [ ] Refresh tokens bound to client
