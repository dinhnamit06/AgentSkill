/**
 * File: src/lib/slug.ts
 * Feature: BIZ-001 rut gon URL — tao slug duy nhat
 * Spec: SPEC-001:5 (retry 3)
 * Prompt: PROMPT-001 khoi 5
 * Author: AI (tao-prompt) + human review — 2026-08-22
 * Tech: nanoid 6 ky tu a-zA-Z0-9 — nhanh, 56B to hop, da audit
 * Test: src/lib/slug.test.ts + src/features/links/links.test.ts
 * WHY: Tach ham thuan de test khong can DB, tai dung cho BIZ-006 customSlug
 */
import { customAlphabet } from "nanoid";
import type { PrismaClient } from "@prisma/client";
import { AppError } from "./errors.js";

// WHY: chi lay a-zA-Z0-9 — gon, khong _- de tranh nham URL encode (BR1)
const SLUG_LEN = 6; // WHY: BR1 — 6 ky tu du 56B to hop, vua ngan vua an toan
const nanoid = customAlphabet("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", SLUG_LEN);

/**
 * Tao 1 slug 6 ky tu. Khong dam bao duy nhat — caller phai check DB.
 */
export function generateSlug(): string {
  return nanoid();
}

/**
 * Tao slug duy nhat, retry 3 lan neu trung DB.
 * WHY retry 3? Du de tranh trung khi tai cao, khong loop vo han.
 */
export async function generateUniqueSlug(prisma: PrismaClient): Promise<string> {
  for (let i = 0; i < 3; i++) {
    const slug = generateSlug();
    const exists = await prisma.link.findUnique({ where: { slug } });
    if (!exists) return slug;
  }
  throw new AppError("SLUG_FAILED", 500, "Khong tao duoc slug sau 3 lan thu");
}
