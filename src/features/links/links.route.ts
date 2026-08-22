/**
 * File: src/features/links/links.route.ts
 * Feature: BIZ-001 — POST /api/links (Route tang, chi validate → goi service)
 * Spec: SPEC-001:4 — POST /api/links 201 {slug, shortUrl}
 * Author: AI (tao-prompt PROMPT-001) — 2026-08-22
 * WHY: Route khong chua BR, khong goi prisma truc tiep — tach bien de test de, doi DB khong dung Route (21_FILE_STRUCTURE:3)
 */
import type { FastifyInstance } from "fastify";
import { CreateLinkSchema } from "./links.schema.js";
import { createLinkService } from "./links.service.js";
import { AppError } from "../../lib/errors.js";

export async function linksRoutes(app: FastifyInstance) {
  app.post("/api/links", async (request, reply) => {
    const parsed = CreateLinkSchema.safeParse(request.body);
    if (!parsed.success) {
      const msg = parsed.error.issues[0]?.message ?? "Du lieu khong hop le";
      const code = msg.includes("Thieu") ? "MISSING_URL" : "INVALID_URL";
      return reply.code(400).send({ error: msg, code });
    }

    try {
      const result = await createLinkService(parsed.data);
      return reply.code(201).send(result);
    } catch (e) {
      if (e instanceof AppError) {
        return reply.code(e.status).send({ error: e.message, code: e.code });
      }
      request.log.error(e);
      return reply.code(500).send({ error: "Loi server", code: "INTERNAL" });
    }
  });
}
