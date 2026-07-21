# Deserialization Hunting Skill — 5 Test Cases

> Load when: deserialization, unsafe deserialization, object injection, serialized object.

## 192. PHP object injection (medium)
Send `O:8:"stdClass":0:{}` or crafted serialized string. If error mentions class not found, deserialization is occurring.

## 193. Java deserialization (hard)
Send `aced0005` (magic bytes) in request body. If `java.io.InvalidClassException` or `ClassCastException` in error, report.

## 194. Python pickle deserialization (hard)
Send `S'os'\nVid\n.` (pickle payload). If command execution occurs, report RCE.

## 195. .NET deserialization (hard)
Send `AAEAAAD/////AQAAAAAAAAAMAgAAAFRlc3Q...` (base64 BinaryFormatter). Check for gadget chains.

## 196. YAML/JSON deserialization (hard)
Send `!!python/object/apply:os.system ["id"]` in YAML. If executed, report RCE via YAML parser.

---

## Deserialization Indicators
| Indicator | Meaning |
|-----------|---------|
| Class not found error | Deserialization occurring |
| InvalidClassException | Java deserialization |
| SerializationError | Python/Ruby deserialization |
| Object reference in response | Deserialized object reflected |
| Magic bytes `aced0005` | Java serialized object |
