# STACK PRESET: Dart + Flutter 3.x (Mobile)

> Dùng khi dự án cần app iOS/Android (hoặc desktop) với 1 codebase.

## Khi nào dùng
- App mobile là sản phẩm chính (ví dụ BeShort mobile)
- Team có Flutter dev hoặc muốn học Dart
- Cần UI mượt 60fps, gần native, release nhanh 2 platform

## Stack chi tiết

| Lớp | Chọn | Vì sao |
|-----|------|--------|
| Language | **Dart 3.x (null-safety, records, pattern matching)** | Performance AOT, hot reload |
| Framework | **Flutter 3.x** | 1 code → iOS/Android/Web/Desktop |
| State | **Riverpod 2.x** (khuyên) hoặc Bloc | Riverpod compile-safe, test dễ; Bloc chuẩn enterprise |
| Network | **Dio + Retrofit** hoặc `http` | Dio có interceptor, retry |
| DB local | **Isar / Hive / drift (sqlite)** | Isar nhanh, drift SQL-like |
| Backend | **Node/TS hoặc Dart Frog / Supabase** | Nếu đã có Node backend thì Flutter chỉ gọi REST |
| Test | **flutter_test + mockito + patrol (e2e)** | — |

## Quy trình vibe với Flutter

```
Pha 2: Spec Dart (model freezed, api contract)
Pha 3: 1 slice = 1 feature (vd: tạo link ngắn: UI form + gọi API + test widget)
Pha 4: Review (check 60fps, rebuild tránh unnecessary)
Pha 5: UI polish (ThemeData, responsive)
```

## Lệnh chuẩn

```bash
flutter create --org com.beshort app
flutter pub add flutter_riverpod dio freezed_annotation
dart run build_runner build
flutter test
```

## Lưu ý cho AI

> Flutter AI gen chưa tốt bằng React — luôn đưa `pubspec.yaml` + 1 widget mẫu vào context. Mỗi prompt chỉ 1 widget/screen.

---
*Teams: nếu làm cả web (React) + mobile (Flutter), dùng monorepo `apps/web` + `apps/mobile` + `packages/shared-types`.*
