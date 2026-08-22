/**
 * File: src/features/links/links.service.ts
 * Feature: BIZ-001 — tao link (Service tang, chua BR)
 * Spec: SPEC-001:5 — generate slug + luu DB + retry 3
 * Author: AI (tao-prompt PROMPT-001) — 2026-08-22
 * WHY: Tach Service khoi Route de test BR khong can HTTP, de tai dung cho worker
 */
import { prisma } from "../../db/client.js";
import { generateUniqueSlug } from "../../lib/slug.js";
import { AppError } from "../../lib/errors.js";
import type { CreateLinkInput } from "./links.schema.js";

const BLACKLIST: string[] = []; // WHY: de rong demo, them "phishing.com" khi can (BR2)
const GUEST_TTL_DAYS = 30; // WHY: BR3 — Guest het han 30 ngay, Member khong han

export async function createLinkService(input: CreateLinkInput) {
  const url = input.url.trim();

  // WHY: check blacklist truoc khi ton slug/DB (BR2)
  try {
    const host = new URL(url).hostname;
    if (BLACKLIST.includes(host)) throw new AppError("DOMAIN_BLOCKED", 400, "Domain bi chan");
  } catch (e) {
    if (e instanceof AppError) throw e;
    throw new AppError("INVALID_URL", 400, "URL khong hop le");
  }

  const slug = await generateUniqueSlug(prisma);

  // WHY: expiresAt +30d cho Guest (ownerId null), Member de null (BIZ-003 se sua)
  const expiresAt = new Date(Date.now() + GUEST_TTL_DAYS * 24 * 60 * 60 * 1000);

  const link = await prisma.link.create({
    data: { slug, originalUrl: url, expiresAt },
  });

  return {
    slug: link.slug,
    shortUrl: `https://beshort.ly/${link.slug}`,
  };
}
