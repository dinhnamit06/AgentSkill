/**
 * File: src/features/links/links.schema.ts
 * Feature: BIZ-001 rut gon URL
 * Spec: SPEC-001:2 — zod + branded types
 * Author: AI (tao-prompt PROMPT-001) — 2026-08-22
 * WHY: zod = validate + type + message VN 3 trong 1, tach rieng de Route chi import 1 file
 */
import { z } from "zod";

export const CreateLinkSchema = z.object({
  url: z.string({ required_error: "Thieu url" }).url({ message: "URL khong hop le" }).max(2048),
});

export type CreateLinkInput = z.infer<typeof CreateLinkSchema>;

export interface CreateLinkResponse {
  slug: string;
  shortUrl: string;
}
