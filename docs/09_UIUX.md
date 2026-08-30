# 09 — UI/UX: Làm sau cùng, làm ít mà đẹp

> Nguyên tắc: Logic vững rồi mới khoác áo. UI ở pha 5 không được làm vỡ logic.

## Khi nào làm UI?

* Sau khi P0 logic (BIZ-001→003) đã Done + test xanh 100%
* Trước đó chỉ làm **wireframe low-fi** (Figma hoặc giấy) để lấy feedback — không code

## Quy trình 4 bước cho 1 màn hình

```
1. Wireframe (30p): phác layout bằng khung xám, không màu
   → User duyệt luồng

2. Tokens (30p): định nghĩa colors, spacing, typography trong tailwind.config.ts
   → Dùng shadcn/ui làm base, không tự invent component

3. Implement (1 slice): 1 component = 1 TASK, colocate test
   → Ví dụ: TASK-007 UI form rút gọn — chỉ render form + gọi POST /api/links đã có

4. Verify (15p): screenshot before/after, check responsive (375px, 768px, 1280px), a11y (keyboard, contrast)
```

## Quy tắc cho AI khi gen UI

* Mỗi prompt chỉ 1 component/screen, có reference `src/components/ui/button.tsx:1` (shadcn pattern)
* Không để AI tự chọn màu — đưa tokens trước
* Không gen logic nghiệp vụ trong UI — UI chỉ gọi API đã có, hiển thị loading/error/success
* File ≤300 dòng, tách `hooks/useCreateLink.ts` nếu logic dài

## Ví dụ BeShort: Form rút gọn

```tsx
// src/components/ShortenForm.tsx — Pha 5, sau khi POST /api/links đã có
import { useState } from "react";
import { Button } from "@/components/ui/button";

export function ShortenForm() {
  const [url, setUrl] = useState("");
  // chỉ gọi API đã có, không tự tạo slug ở FE
  const { mutate, data, isPending } = useCreateLink();
  return (
    <form onSubmit={(e) => { e.preventDefault(); mutate({ url }); }}>
      <input value={url} onChange={e => setUrl(e.target.value)} placeholder="Dán link dài..." />
      <Button disabled={isPending}>Rút gọn</Button>
      {data && <a href={data.shortUrl}>{data.shortUrl}</a>}
    </form>
  );
}
```

## Checklist trước khi merge UI

- [ ] Logic cũ vẫn pass `npm test` (không vỡ)
- [ ] Screenshot 3 breakpoint
- [ ] Keyboard navigable, contrast ≥4.5:1
- [ ] Không thêm endpoint mới trong PR UI

---
*Học để tự làm UI: Nắm 4 bước trên + đọc shadcn/ui docs — sau này không cần file này vẫn biết khi nào tách component.*
