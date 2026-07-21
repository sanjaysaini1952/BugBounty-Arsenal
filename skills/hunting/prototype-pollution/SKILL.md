# Prototype Pollution Hunting Skill — 4 Test Cases

> Load when: prototype pollution, JS prototype, `__proto__`, `constructor`.

## 252. Basic prototype pollution (medium)
Send `{"__proto__":{"isAdmin":true}}` in JSON body. Check if new objects have `isAdmin: true`.

## 253. Prototype pollution to XSS (hard)
If app uses `innerHTML` with user-controlled property, pollute `toString` or `valueOf` to execute code.

## 254. Prototype pollution to RCE (hard)
Chain with template engine or `child_process.exec` gadget. Pollute `shell` or `exec` property.

## 255. Prototype pollution in query string (medium)
Test: `?__proto__[isAdmin]=true` in URL. Report if query parser pollutes prototype.

---

## Prototype Pollution Detection
| Test | Expected |
|------|----------|
| `{"__proto__":{"test":"polluted"}}` | New objects have `test` property |
| `?__proto__[test]=polluted` | Query parser pollutes prototype |
| `{"constructor":{"prototype":{"test":"polluted"}}}` | Constructor chain pollution |
