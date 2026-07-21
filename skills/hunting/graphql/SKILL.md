# GraphQL Security Testing Skill — 6 Test Cases

> Load when: GraphQL, introspection, GraphQL injection, batching.

## 202. Introspection query (easy)
Send `{__schema{types{name,fields{name,args{name}}}}}`. Report full schema disclosure.

## 203. GraphQL batching attack (medium)
Send `[{query1}, {query2}, ...]` in single request. Report if batching bypasses rate limiting.

## 204. GraphQL field suggestion (easy)
Send `{user(name:"admin"){id}}`. If response suggests correct field names, report information disclosure.

## 205. GraphQL IDOR (medium)
Query other users' data by changing `id` parameter: `user(id: 2){email,name}`. Report unauthorized access.

## 206. GraphQL mutation without auth (medium)
Send mutation (create user, change password) without authentication. Report missing auth checks.

## 207. GraphQL query depth attack (hard)
Send deeply nested query: `{user{friends{friends{friends{...}}}}}`. Report if no depth limiting causes DoS.

---

## GraphQL Testing Queries
```graphql
# Introspection
{__schema{types{name,fields{name,args{name,type{name}}}}}}

# Field Suggestion
{user(name:"admin"){id,email}}

# Batching
[{query:"{user(id:1){name}}"},{query:"{user(id:2){name}}"}]

# Mutation
mutation{createUser(input:{name:"test",email:"test@test.com"}){id}}
```
