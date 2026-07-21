# Business Logic Hunting Skill — 12 Test Cases

> Load when: business logic, logic flaw, workflow bypass, price manipulation, negative quantity.

## 148. Price manipulation (easy)
Change price in request body, hidden fields, or API calls. Test: negative prices, zero prices, large discounts.

## 149. Quantity manipulation (easy)
Set quantity to negative, zero, or very large numbers. Check if negative quantities result in refunds or credit.

## 150. Coupon abuse (medium)
Apply multiple coupons, reuse expired coupons, use coupons on discounted items, stack percentage discounts.

## 151. Step skipping in checkout (easy)
Skip from cart directly to confirmation. Check if payment step is enforced server-side.

## 152. Step skipping in registration (easy)
Skip email verification, skip 2FA setup. Check if account is fully functional.

## 153. Subscription manipulation (medium)
Change subscription tier in requests, apply promotional pricing to paid plans, manipulate trial period.

## 154. Voting/rating manipulation (easy)
Vote/rate same item multiple times. Check if IP or user-based rate limiting exists.

## 155. Refund abuse (medium)
Request refund after using purchased item. Test refund to different payment method.

## 156. Gift card / wallet manipulation (medium)
Create gift card with zero balance, redeem gift cards multiple times, transfer between wallets.

## 157. User role manipulation (easy)
Change `role`, `isAdmin`, `permissions` in requests. Check if role changes are enforced server-side.

## 158. Multi-use single-use codes (easy)
Use single-use invitation codes, discount codes, or access tokens multiple times.

## 159. Negative quantity in shopping cart (medium)
Add item with quantity -1. Check if it adds credit or causes errors. Also test decimal quantities.

---

## Common Business Logic Flaws
| Category | Test |
|----------|------|
| Price | Change price in request, negative prices, zero prices |
| Quantity | Negative quantities, zero, overflow |
| Step order | Skip steps, go backwards, repeat steps |
| Time | Replay expired coupons, manipulate trial dates |
| Role | Privilege escalation via role change |
| State | Force state transitions, skip validation |
