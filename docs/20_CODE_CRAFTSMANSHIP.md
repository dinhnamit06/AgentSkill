# 20 — CODE CRAFTSMANSHIP: Vibe code ngắn gọn, dễ hiểu, dễ scale (tư duy thợ + kiến trúc sư)

> **Châm ngôn thợ:** “Code như viết cho người mới vào team 6 tháng sau — người đó có thể là chính bạn.” Code rác chạy được hôm nay, nhưng 3 tháng sau bạn tự chửi mình.
> **Châm ngôn kiến trúc sư:** “Làm đủ cho hôm nay, mở cửa cho ngày mai — không xây thừa, không khóa đường.”

---

## 1. Tại sao AI hay gen code rác? Và cách chặn

| AI hay làm | Tại sao là rác | Cách chặn bằng prompt (16_PROMPT_MASTERY) | Check ở đâu |
|------------|----------------|--------------------------------------------|-------------|
| 1 file 600 dòng, 1 hàm 200 dòng | Không review nổi, sửa 1 chỗ vỡ 3 chỗ | Khối 5: `File ≤300 dòng, hàm ≤50 dòng, vượt → tách` | `06_REVIEW: readability` |
| Tên `data`, `result`, `tmp` | Đọc 10s không biết là gì | Khối 5: `Tên phải nói rõ là gì — slug, originalUrl` | `14_CODE_READING_GUIDE:3` |
| Copy-paste 3 lần thay vì tách hàm | Sửa 1 chỗ quên 2 chỗ | Khối 5: `DRY — trùng 3 lần thì tách hàm` | Review |
| Dựng abstraction sớm (Factory, BaseClass) khi chỉ có 1 case | Thừa, khó hiểu, không dùng tới | Khối 5: `YAGNI — không làm thừa cho tương lai, chỉ làm đủ cho AC hôm nay` | ADR |
| `if` lồng 4 cấp, `try/catch` bọc cả file | Bug ẩn, test khó | Khối 5: `Early return, guard clause, hàm ngắn` | Review |
| Magic number `6`, `30`, `429` không giải thích | Đọc không biết 6 là gì | Khối 5: `Đặt const SLUG_LEN=6, GUEST_TTL_DAYS=30 + comment WHY` | Review |
| Throw string, không typed error | FE không biết bắt lỗi gì | Khối 5: `Dùng AppError {code, status}` | `12_HANDOVER S1` |

**Prompt chặn rác (dán vào khối 5 mọi PROMPT):**
```
Rang buoc tho code:
- File ≤300 dong, ham ≤50 dong, vuot → tach file/ham moi
- Ten ro nghia (slug, originalUrl), khong data/tmp/result
- DRY: trung 3 lan → tach ham, khong copy-paste
- YAGNI: chi lam du cho AC hom nay, khong ve tuong lai
- Early return, it nhat nesting, khong magic number (dat const + WHY)
- Header 3 Biet + comment WHY, khong comment WHAT
```

---

## 2. Tư duy thợ — 7 quy tắc viết code ngắn gọn, dễ hiểu

### Quy tắc 1: Hàm làm 1 việc, tên nói việc đó

```typescript
// XAU — ham lam 3 viec, ten mo ho, 80 dong
function handleLink(data: any) { /* validate + tao slug + luu DB + gui email */ }

// TOT — 3 ham, moi ham 1 viec, ten ro, moi ham ≤30 dong
function parseCreateLinkInput(raw: unknown): CreateLinkInput { /* validate zod */ }
function generateUniqueSlug(prisma: Prisma): Promise<Slug> { /* retry 3 */ }
function saveLink(input: CreateLinkInput, slug: Slug): Promise<Link> { /* prisma.create */ }
```

**Tại sao dễ scale?** Mai thêm `customSlug` chỉ sửa `parseCreateLinkInput`, không đụng DB.

### Quy tắc 2: Early return — ít lồng, dễ đọc

```typescript
// XAU — long 3 cap
if (url) {
  if (isValid(url)) {
    if (!isBlocked(url)) { /* ... */ }
  }
}

// TOT — guard, moi if la 1 canh bao
if (!url) throw new AppError("MISSING_URL", 400);
if (!isValid(url)) throw new AppError("INVALID_URL", 400);
if (isBlocked(url)) throw new AppError("DOMAIN_BLOCKED", 400);
// happy path o day — khong long
```

### Quy tắc 3: Không magic number

```typescript
// XAU
if (slug.length !== 6) ...

// TOT
const SLUG_LENGTH = 6; // WHY: BR1 — 6 ky tu du 56B to hop, vua ngan vua an toan
if (slug.length !== SLUG_LENGTH) ...
```

### Quy tắc 4: Đặt tên là tài liệu

```typescript
// XAU
const d = await getData(id); // d la gi?
const res = await fetch(url); // res cua ai?

// TOT
const link = await findLinkBySlug(slug);
const response = await fetchOriginalUrl(link.originalUrl);
```

### Quy tắc 5: File ngắn — tách theo trục thay đổi

```
src/routes/links.ts      → chi route (validate → goi service → tra response)
src/services/linkService.ts → logic tao slug + luu DB
src/lib/slug.ts          → ham tao slug thuan (de test, de tai dung)
src/schemas/link.ts      → zod schema
```

**Tại sao?** Đổi DB (Prisma → Drizzle) chỉ sửa `linkService.ts`, không đụng route.

### Quy tắc 6: Không comment WHAT, chỉ WHY

```typescript
// XAU — lap lai code
// Tao slug
const slug = nanoid(6);

// TOT — giai thich quyet dinh
// WHY: nanoid 6 ky tu + retry 3 — du an toan, nhanh hon crypto.randomUUID (benchmark 2x)
const slug = nanoid(6);
```

### Quy tắc 7: Test là ví dụ sống

Mỗi hàm phức tạp có test cạnh bên — test chính là docs dễ hiểu hơn comment.

---

## 3. Tư duy kiến trúc sư — Làm sao để dễ mở rộng, dễ scale

### Nguyên tắc 1: Đủ cho hôm nay, mở cho ngày mai (YAGNI + Open/Closed)

* **Hôm nay (BIZ-001):** Guest tạo link 6 ký tự → chỉ làm `generateSlug()` + `saveLink()`
* **Ngày mai (BIZ-006):** Cho phép `customSlug` → thêm param `customSlug?: string` vào `CreateLinkInput`, không sửa hàm cũ — mở rộng bằng thêm branch, không sửa logic cũ.

```typescript
// Kien truc mo: them tinh nang bang them nhanh, khong sua ham cu
export async function createLink(input: CreateLinkInput) {
  const slug = input.customSlug ?? await generateUniqueSlug(prisma); // mo rong khong pha vo
}
```

### Nguyên tắc 2: Tách biên (Boundary) — FE không biết DB, Route không biết Prisma

```
[FE] --fetch--> [Route: validate zod] --goi--> [Service: business logic] --goi--> [DB: Prisma]
```

Route chỉ làm 3 việc: validate → gọi service → trả response. Service chứa BR. DB chỉ lưu. Đổi DB không đụng Route.

### Nguyên tắc 3: Cấu trúc theo feature, không theo loại file

```
// XAU — chia theo loai file, tim 1 feature phai mo 5 folder
src/controllers/
src/models/
src/utils/

// TOT — chia theo feature (vertical slice), 1 TASK = 1 folder
src/features/links/
  ├── links.route.ts
  ├── links.service.ts
  ├── links.schema.ts
  └── links.test.ts
```

**Scale:** Thêm feature `analytics` → tạo `src/features/analytics/` mới, không đụng `links/`.

### Nguyên tắc 4: Config, không hardcode

```typescript
// XAU — doi limit phai sua code
if (count > 10) throw ...

// TOT — doi bang env, khong deploy lai
const GUEST_RATE_LIMIT = Number(process.env.GUEST_RATE_LIMIT ?? 10);
if (count > GUEST_RATE_LIMIT) throw ...
```

### Nguyên tắc 5: Đo trước, tối ưu sau

Không tối ưu sớm. Viết code rõ trước, khi nào `p95 >300ms` mới tối ưu (thêm index, cache). `12_HANDOVER_CHECKLIST:3` có checklist performance để đo.

---

## 4. Prompt vibe code sạch — Dán vào khối 5

```
Tho code + kien truc su:
- File ≤300, ham ≤50, ten ro nghia, khong data/tmp, khong magic number (dat const + WHY)
- Moi ham 1 viec, early return, it nesting, DRY 3 lan → tach, YAGNI khong lam thua
- Tach bien: Route (validate) → Service (BR) → DB (Prisma), chia theo feature (src/features/links/)
- Header 3 Biet + WHY, test colocated, AppError co code
- Config bang env, khong hardcode
```

AI gen xong, tự hỏi: `Junior 1 tuan doc file 5p hieu khong? Mui them 1 field co phai sua 5 file khong? Neu co → chua sach.`

---

## 5. Checklist “Thợ & Kiến trúc sư” trước khi merge (thêm vào REVIEW)

- [ ] File ≤300, hàm ≤50, không hàm 100 dòng?
- [ ] Tên rõ nghĩa, không `data/tmp/result`, không magic number?
- [ ] Mỗi hàm 1 việc, early return, không lồng 3 cấp?
- [ ] Đã tách theo feature/biên, đổi 1 feature không đụng 5 file?
- [ ] Không abstraction thừa (YAGNI), không copy-paste 3 lần?
- [ ] Config bằng env, không hardcode limit/URL?
- [ ] Header 3 Biết + WHY đủ, junior đọc 5p hiểu?

Nếu 7 câu đều có → code này **ngắn gọn, dễ hiểu, dễ scale** — thợ duyệt, kiến trúc sư duyệt.

---
*Liên quan: `14_CODE_READING_GUIDE.md:1` (đọc) → `06_REVIEW/_TEMPLATE.md:1` (check) → `15_HOC_VIBE.md:2` (khối 5) → `11_KIEN_TRUC.md:1` (cấu trúc).*
