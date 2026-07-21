# Google Dorks Collection (Consolidated)

## Sensitive Files
```
site:target.com ext:log
site:target.com ext:sql
site:target.com ext:bak
site:target.com ext:old
site:target.com ext:conf
site:target.com ext:ini
site:target.com ext:env
site:target.com ext:xml
site:target.com ext:json
site:target.com ext:yml
site:target.com ext:yaml
site:target.com ext:config
site:target.com ext:backup
site:target.com ext:dump
site:target.com ext:csv
site:target.com ext:pdf
site:target.com ext:py
site:target.com ext:js
site:target.com ext:sh
```

## Admin Panels
```
site:target.com intitle:"admin"
site:target.com intitle:"login"
site:target.com inurl:admin
site:target.com inurl:login
site:target.com inurl:dashboard
site:target.com inurl:cpanel
site:target.com inurl:"/wp-admin"
site:target.com inurl:"/phpmyadmin"
```

## API Discovery
```
intitle:"Swagger UI" site:target.com
intitle:"API" site:target.com
site:target.com inurl:api
site:target.com inurl:v1 OR inurl:v2 OR inurl:v3
site:target.com inurl:graphql
site:target.com inurl:swagger
site:target.com inurl:openapi
```

## File Upload Forms
```
site:target.com "Choose File"
site:target.com "No file chosen"
site:target.com "Upload"
site:target.com "Upload here"
site:target.com "Upload a file"
site:target.com "Please upload your"
site:target.com inurl:upload
```

## Info Disclosure
```
site:target.com "error" OR "warning" OR "fatal"
site:target.com "mysql_" OR "ORA-" OR "PostgreSQL"
site:target.com "Stack trace" OR "Exception"
site:target.com "debug" OR "debugging"
site:target.com intitle:"index of" "parent directory"
site:target.com inurl:phpinfo
site:target.com inurl:".env"
site:target.com inurl:".git"
```

## Subdomains
```
site:*.target.com -www -www1 -blog
site:*.target.com inurl:login
site:*.target.com inurl:admin
site:*.target.com inurl:dev
site:*.target.com inurl:staging
site:*.target.com inurl:test
site:*.target.com inurl:beta
```

## Login Pages (Extended)
```
site:*<*.target.com intext:"login" | intitle:"login" | inurl:"login" | intext:"username" | intitle:"username" | inurl:"username" | intext:"password" | intitle:"password" | inurl:"password"
```

## Exposed Credentials
```
site:target.com "password" filetype:txt
site:target.com "password" filetype:log
site:target.com inurl:config password
site:target.com "BEGIN RSA PRIVATE KEY"
site:target.com "API_KEY" OR "API_SECRET"
site:target.com "client_secret"
site:target.com "database_password"
```

## Internal Tools
```
site:target.com intitle:"Jenkins"
site:target.com intitle:"Kibana"
site:target.com intitle:"Grafana"
site:target.com intitle:"SonarQube"
site:target.com intitle:"GitLab"
site:target.com intitle:"Jira"
site:target.com intitle:"Confluence"
site:target.com inurl:"/jupyter"
site:target.com inurl:"/airflow"
```

## Bug Bounty Target Discovery
```
site:hackerone.com "target.com"
site:bugcrowd.com "target.com"
site:intigriti.com "target.com"
"bug bounty" "target.com"
```
