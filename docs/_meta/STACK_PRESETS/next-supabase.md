# STACK PRESET: Next.js + Supabase (Fullstack nhanh)

> Khi cần SSR/SEO hoặc muốn fullstack trong 1 repo, ít tự quản infra.

## Khi nào dùng
- Marketing site, blog, landing cần SEO
- Muốn Supabase lo hết Auth + DB + Storage + Realtime
- Team nhỏ, cần ship <1 tuần

## Stack

| Lớp | Chọn |
|-----|------|
| Frontend+Backend | **Next.js 14 (App Router) + TypeScript** |
| DB/Auth/Storage | **Supabase (Postgres + Auth + Storage)** |
| ORM | **Supabase JS + Prisma (optional)** |
| Styling | **Tailwind 4 + shadcn/ui** |
| Test | **Vitest + Playwright** |
| Deploy | **Vercel** |

## Lệnh

```bash
npx create-next-app@latest --typescript --tailwind --app
npx supabase init
```

## Trade-off

* **Ưu:** Ít config, AI gen Next.js rất tốt, Supabase free tier đủ dùng
* **Nhược:** Vendor lock-in Supabase, khó custom sâu như tách FE/BE riêng

---
*Nếu sau này scale lớn → tách BE ra Fastify riêng, giữ Next chỉ làm BFF.*
