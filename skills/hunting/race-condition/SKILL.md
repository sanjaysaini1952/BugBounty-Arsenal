# Race Condition Hunting Skill — 8 Test Cases

> Load when: race condition, TOCTOU, time-of-check time-of-use, concurrent request.

## 140. Race condition in fund transfer (medium)
Send 10 simultaneous transfer requests (same amount, same account). Check if balance allows multiple transfers beyond available funds.

## 141. Race in coupon redemption (medium)
Send simultaneous requests to redeem same coupon code. Check if used once or multiple times.

## 142. Race in OTP verification (medium)
Send parallel OTP verification requests. Check if multiple attempts bypass rate limiting.

## 143. Race in inventory (medium)
Send concurrent add-to-cart or purchase requests for limited stock. Check overselling.

## 144. Race in token generation (medium)
Request password reset or API tokens simultaneously. Check if multiple valid tokens are generated (only last should be valid).

## 145. Race in account creation (medium)
Create same user simultaneously. Check if duplicate accounts or inconsistent state results.

## 146. Race in multi-step process (hard)
In workflows (checkout, onboarding), send intermediate steps out of order or concurrently. Check state inconsistencies.

## 147. Race in file operations (hard)
Upload and delete same file simultaneously. Check for TOCTOU vulnerability (file exists check vs. actual operation).

---

## Testing Methodology
1. Identify state-changing endpoints
2. Use multiple threads (Turbo Intruder, Burp Group Send, custom script)
3. Send 10-50 concurrent requests
4. Analyze response for anomalies
5. Check state after race (balance, count, state)
6. Verify reproducibility
7. Document with timestamps and evidence

## Race Detection Heuristics
| Signal | Description |
|--------|-------------|
| Balance anomaly | More transfers than balance allows |
| Duplicate resources | Two users with same username |
| Count mismatch | Counter says 5, actual items 7 |
| State corruption | Mixed/invalid state in database |
