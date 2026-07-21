# Shodan Dorks Collection

## Admin Panels & Dashboards
```
ssl:"target.com" http.status:200 http.title:"dashboard"
org:"target.com" http.title:"phpMyAdmin"
ssl:"target.com" http.title:"BIG-IP" vuln:CVE-2020-5902
ssl.cert.subject.CN:*.target.com http.title:"Dashboard [Jenkins]"
ssl.cert.subject.CN:"*.target.com"+200 http.title:"Admin"
org:"Company Inc" http.title:dashboard
net:"I.P.v.4/CIDR" http.title:dashboard
asn:AS19551 http.title:"dashboard"
http.title:"Swagger UI" org:"Target"
http.title:"Django REST framework"
```

## Exposed Services
```
org:"target.com" http.component:"jenkins" http.status:200
ssl:"target.com" http.status:200 product:"ProFTPD" port:21
http.html:"xoxb-"  (Slack tokens)
http.html:"AKIA"  (AWS keys)
http.html:"AIza"  (Google API keys)
http.title:"Index Of /"
http.title:"Directory Listing" org:organization-name
product:"Splunk"
Ssl:"domain" 200 http.title:"citrix gateway"
org:Company http.status:"403"
Set-Cookie:"mongo-express=" "200 OK"
ssl.cert.subject.CN:"*.target.com" "230 login successful" port:"21"
http.html:"The wp-config.php creation script uses this file"
http.html:"apollo-adminservice"
```

## Vulnerability Checks
```
http.html:"zabbix" vuln:CVE-2022-24255
http.title:"MobileIron" OR http.favicon.hash:362091310  (CVE-2023-35078)
ssl:"target.com" http.title:"BIG-IP" vuln:CVE-2020-5902
```

## Hidden APIs
```
http.title:"swagger" org:"target"
http.title:"api" port:8080
http.title:"graphql" org:"target"
http.title:"kong" port:8000
http.title:"consul" port:8500
```

## Databases
```
product:"MySQL" org:"target"
product:"PostgreSQL" org:"target"
product:"MongoDB" org:"target"
product:"Redis" org:"target" port:6379
product:"Elasticsearch" org:"target" port:9200
```

## Internal Tools Exposed
```
http.title:"Grafana" org:"target"
http.title:"Kibana" org:"target"
http.title:"Jenkins" org:"target"
http.title:"GitLab" org:"target"
http.title:"SonarQube" org:"target"
http.title:"Kubernetes" org:"target"
```
