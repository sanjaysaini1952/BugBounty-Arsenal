# HUNTING SKILLS INDEX — 308 Test Cases

## Quick Reference by Vuln Class

| # | Skill | File | Test Cases |
|---|-------|------|------------|
| 1 | XSS | `xss/SKILL.md` | #1–25 |
| 2 | SQLi | `sqli/SKILL.md` | #26–40 |
| 3 | SSRF | `ssrf/SKILL.md` | #41–55 |
| 4 | IDOR/BAC | `idor/SKILL.md` | #56–70 |
| 5 | Auth Bypass | `auth-bypass/SKILL.md` | #71–87 |
| 6 | CSRF | `csrf/SKILL.md` | #88–97 |
| 7 | File Upload | `file-upload/SKILL.md` | #98–109 |
| 8 | RCE | `rce/SKILL.md` | #110–119 |
| 9 | XXE | `xxe/SKILL.md` | #120–125 |
| 10 | SSTI | `ssti/SKILL.md` | #126–133 |
| 11 | Open Redirect | `open-redirect/SKILL.md` | #134–139 |
| 12 | Race Condition | `race-condition/SKILL.md` | #140–147 |
| 13 | Business Logic | `business-logic/SKILL.md` | #148–159 |
| 14 | API Security | `api/SKILL.md` | #160–171 |
| 15 | JWT/OAuth | `jwt-oauth/SKILL.md` | #172–189 |
| 16 | CORS | `cors/SKILL.md` | #190–195 |
| 17 | Path Traversal | `lfi-path-traversal/SKILL.md` | #196–201 |
| 18 | Deserialization | `deserialization/SKILL.md` | #202–206 |
| 19 | Subdomain Takeover | `subdomain-takeover/SKILL.md` | #207–211 |
| 20 | GraphQL | `graphql/SKILL.md` | #212–217 |
| 21 | Mobile | `mobile/SKILL.md` | #218–223 |
| 22 | Cloud/AWS | `cloud/SKILL.md` | #224–231 |
| 23 | Crypto | `crypto/SKILL.md` | #232–237 |
| 24 | Security Headers | `security-headers/SKILL.md` | #238–243 |
| 25 | Web Cache | `cache/SKILL.md` | #244–249 |
| 26 | WebSocket | `websocket/SKILL.md` | #250–253 |
| 27 | Prototype Pollution | `prototype-pollution/SKILL.md` | #254–257 |
| 28 | NoSQL | `nosql/SKILL.md` | #258–260 |
| 29 | LDAP | `ldap/SKILL.md` | #261–263 |
| 30 | Command Injection | `command-injection/SKILL.md` | #264–266 |
| 31 | Info Disclosure | `info-disclosure/SKILL.md` | #267–276 |
| 32 | Recon | `recon/SKILL.md` | #277–284 |
| 33 | LLM/AI | `llm-ai/SKILL.md` | #285–298 |
| 34 | Supply Chain | `supply-chain/SKILL.md` | #299–302 |
| 35 | DoS | `dos/SKILL.md` | #303–308 |

## Full Test Case List

### XSS (#1–25)
1. Reflected XSS in search bar
2. Stored XSS in profile fields
3. DOM XSS via URL fragment
4. XSS via SVG upload
5. XSS via PDF/HTML render
6. XSS via Markdown renderer
7. XSS via JSON content-type confusion
8. Mutation XSS in sanitizers
9. XSS via CSP bypass
10. XSS via error pages
11. XSS in PostMessage handlers
12. XSS via Angular/React template injection
13. XSS via SVG `<use>` xlink:href
14. XSS via filename reflection
15. XSS via HTTP header reflection
16. XSS via email content
17. XSS in CSV/Excel export
18. XSS via redirect URL
19. Self-XSS escalated via CSRF
20. XSS via WebSocket message echo
21. XSS via OAuth state parameter
22. Blind XSS in admin panels
23. XSS via charset confusion
24. XSS in PDF viewer query params
25. XSS via clipboard paste handlers

### SQLi (#26–40)
26. Error-based SQLi probe
27. Boolean-based blind SQLi
28. Time-based blind SQLi
29. UNION-based SQLi column count
30. Second-order SQLi
31. SQLi via ORDER BY / column names
32. NoSQL injection in MongoDB
33. SQLi via JSON parameters
34. Out-of-band SQLi via DNS
35. SQLi in stored procedures
36. SQLi via header values
37. SQLi in LIMIT / OFFSET
38. SQLi via WAF bypass
39. SQLi via INSERT path
40. SQLi via XML body

### SSRF (#41–55)
41. SSRF via URL parameter
42. Blind SSRF via webhook
43. SSRF via PDF generator
44. SSRF via image proxy
45. SSRF via DNS rebinding
46. SSRF via redirect chain
47. SSRF via SVG external entities
48. SSRF in SAML/OIDC metadata URLs
49. SSRF via Slack/Discord previews
50. SSRF via CSV/XLSX import URLs
51. Bypass IP filter with decimals/hex
52. SSRF to internal admin panels
53. SSRF via XML external entity
54. SSRF via OAuth redirect_uri
55. SSRF via Kubernetes API

### IDOR/BAC (#56–70)
56. Sequential ID enumeration
57. IDOR via UUID prediction
58. IDOR via parameter removal
59. BAC on hidden API endpoints
60. IDOR in file downloads
61. Horizontal privilege escalation
62. Vertical privilege escalation
63. IDOR via JSON body manipulation
64. IDOR in batch operations
65. IDOR via GraphQL
66. BAC on admin endpoints
67. IDOR via API versioning
68. IDOR via webhook callbacks
69. IDOR via shared links
70. IDOR in multi-tenant SaaS

### Auth Bypass (#71–87)
71. Password reset token prediction
72. Password reset link reuse
73. Password reset link expiration
74. Auth bypass via response manipulation
75. Auth bypass via case sensitivity
76. Auth bypass via null bytes
77. Auth bypass via JSON type confusion
78. Session fixation
79. JWT alg:none bypass
80. JWT key confusion
81. Session token in URL
82. Auth bypass via redirect
83. 2FA bypass
84. Auth bypass via remember me
85. Auth bypass via API endpoint
86. Brute force protection bypass
87. OAuth token leakage

### CSRF (#88–97)
88. CSRF on email/password change
89. CSRF on account deletion
90. CSRF on admin actions
91. CSRF via JSON content type
92. CSRF with credentials
93. CSRF via OAuth flows
94. CSRF via image tag
95. CSRF on webhook configuration
96. CSRF via fetch with no-cors
97. CSRF on file upload

### File Upload (#98–109)
98. Unrestricted file upload
99. Extension bypass
100. Content-Type bypass
101. Double extension bypass
102. Path traversal in filename
103. SVG XSS upload
104. SVG XXE upload
105. ZIP slip
106. ImageMagick exploit
107. EXIF metadata injection
108. File content validation bypass
109. Filename XSS

### RCE (#110–119)
110. OS command injection
111. Blind command injection via time delay
112. Blind command injection via DNS
113. Code injection via eval()
114. RCE via file upload
115. RCE via template injection + SSTI
116. RCE via deserialization
117. RCE via cron job manipulation
118. RCE via environment variable injection
119. RCE via shared library injection

### XXE (#120–125)
120. Basic XXE file read
121. Blind XXE via error messages
122. Blind XXE via OOB exfiltration
123. XXE in SVG upload
124. XXE in SOAP endpoints
125. XXE in DOCX/XLSX import

### SSTI (#126–133)
126. Basic SSTI detection
127. SSTI to RCE in Jinja2
128. SSTI to RCE in Twig
129. SSTI to RCE in Freemarker
130. SSTI to file read
131. SSTI with WAF bypass
132. SSTI via email template
133. SSTI in log messages

### Open Redirect (#134–139)
134. Basic open redirect
135. Open redirect via path traversal
136. Open redirect in OAuth callback
137. Open redirect via JavaScript
138. Open redirect via URL parsing confusion
139. Open redirect via CNAME

### Race Conditions (#140–147)
140. Race in fund transfer
141. Race in coupon redemption
142. Race in OTP verification
143. Race in inventory
144. Race in token generation
145. Race in account creation
146. Race in multi-step process
147. Race in file operations

### Business Logic (#148–159)
148. Price manipulation
149. Quantity manipulation
150. Coupon abuse
151. Step skipping in checkout
152. Step skipping in registration
153. Subscription manipulation
154. Voting/rating manipulation
155. Refund abuse
156. Gift card/wallet manipulation
157. User role manipulation
158. Multi-use single-use codes
159. Negative quantity in shopping cart

### API Security (#160–171)
160. Mass assignment via JSON
161. Mass assignment via query params
162. HTTP method confusion
163. API versioning bypass
164. API rate limiting bypass
165. Content-Type confusion
166. API enumeration via error messages
167. Excessive data exposure
168. BOLA via API path traversal
169. GraphQL introspection
170. GraphQL batching attack
171. API key exposure in frontend

### JWT/OAuth (#172–189)
172. JWT alg:none attack
173. JWT key confusion
174. JWT secret brute force
175. JWT expired token acceptance
176. JWT claim manipulation
177. JWT kid injection
178. JWT jwk/jku confusion
179. JWT none algorithm + key confusion
180. OAuth redirect_uri open redirect
181. OAuth state parameter missing
182. OAuth token leakage via referrer
183. OAuth token leakage via logs
184. OAuth scope escalation
185. OAuth token replay
186. OAuth PKCE bypass
187. OAuth token in fragment
188. OAuth impersonation via client credentials
189. OAuth token theft via mixed content

### CORS (#190–195)
190. CORS reflect origin
191. CORS null origin
192. CORS subdomain wildcard
193. CORS regex bypass
194. CORS preflight bypass
195. CORS + credential leak chain

### Path Traversal/LFI (#196–201)
196. Basic LFI
197. LFI with null byte
198. LFI with encoding
199. LFI to RCE via log poisoning
200. LFI via /proc/self/environ
201. LFI via php://filter

### Deserialization (#202–206)
202. PHP object injection
203. Java deserialization
204. Python pickle deserialization
205. .NET deserialization
206. YAML/JSON deserialization

### Subdomain Takeover (#207–211)
207. Dangling CNAME detection
208. S3 bucket takeover
209. Heroku/GitHub Pages takeover
210. Azure takeover
211. Expired domain takeover

### GraphQL (#212–217)
212. Introspection query
213. GraphQL batching attack
214. GraphQL field suggestion
215. GraphQL IDOR
216. GraphQL mutation without auth
217. GraphQL query depth attack

### Mobile (#218–223)
218. APK reverse engineering
219. Certificate pinning bypass
220. Insecure data storage
221. Mobile API testing
222. Deep link / URL scheme testing
223. Root/jailbreak detection bypass

### Cloud/AWS (#224–231)
224. S3 bucket enumeration
225. S3 bucket listing
226. Cloud metadata SSRF
227. AWS credentials in environment
228. Azure blob storage
229. GCP bucket enumeration
230. AWS privilege escalation
231. Secrets in cloud config

### Crypto (#232–237)
232. Weak hashing algorithms
233. Predictable tokens
234. Hash length extension attack
235. Padding oracle attack
236. Insecure random number generation
237. TLS misconfiguration

### Security Headers (#238–243)
238. Missing security headers
239. Weak CSP
240. Missing HSTS
241. Missing X-Frame-Options
242. Missing X-Content-Type-Options
243. Information disclosure in headers

### Web Cache (#244–249)
244. Cache poisoning via unkeyed header
245. Cache poisoning via URL path
246. Cache poisoning via query string
247. Cache deception
248. Cache poisoning via Host header
249. Cache key injection

### WebSocket (#250–253)
250. WebSocket XSS
251. WebSocket auth bypass
252. WebSocket origin bypass
253. WebSocket DoS

### Prototype Pollution (#254–257)
254. Basic prototype pollution
255. Prototype pollution to XSS
256. Prototype pollution to RCE
257. Prototype pollution in query string

### NoSQL (#258–260)
258. MongoDB operator injection
259. MongoDB regex injection
260. MongoDB $where injection

### LDAP (#261–263)
261. Basic LDAP injection
262. LDAP search injection
263. LDAP filter injection

### Command Injection (#264–266)
264. Direct command injection
265. Blind command injection
266. Command injection via file upload

### Info Disclosure (#267–276)
267. Sensitive data in API responses
268. Sensitive data in error messages
269. Sensitive data in headers
270. Source code disclosure
271. Directory listing
272. Sensitive files exposure
273. Debug endpoints
274. Version information disclosure
275. Internal IP disclosure
276. API key exposure in frontend

### Recon (#277–284)
277. Subdomain enumeration
278. Port scanning
279. Technology fingerprinting
280. Directory bruteforcing
281. JavaScript analysis
282. Email harvesting
283. Git history analysis
284. Wayback URL analysis

### LLM/AI (#285–298)
285. Direct prompt injection
286. Indirect prompt injection via documents
287. Prompt injection via user input
288. Model jailbreak
289. Data exfiltration via prompt injection
290. Prompt injection to execute code
291. Prompt injection to modify behavior
292. Training data extraction
293. Model extraction
294. Adversarial inputs
295. Resource exhaustion
296. Multi-turn injection
297. System prompt extraction
298. AI agent tool abuse

### Supply Chain (#299–302)
299. Dependency vulnerability scanning
300. Typosquatting detection
301. Malicious package detection
302. CI/CD pipeline injection

### DoS (#303–308)
303. ReDoS
304. Algorithmic complexity attack
305. Resource exhaustion via upload
306. Connection exhaustion
307. Memory exhaustion
308. API rate limiting bypass
