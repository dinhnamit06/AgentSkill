/**
 * Test colocated: src/features/links/links.test.ts — TDD RED truoc GREEN sau (08_TESTING)
 * Chay: npm test
 */
import { describe, it, expect, beforeAll, afterAll } from "vitest";
import Fastify from "fastify";
import { linksRoutes } from "./links.route.js";
import { prisma } from "../../db/client.js";

describe("POST /api/links", () => {
  const app = Fastify();

  beforeAll(async () => {
    await app.register(linksRoutes);
    await app.ready();
    await prisma.link.deleteMany();
  });

  afterAll(async () => {
    await prisma.link.deleteMany();
    await app.close();
    await prisma.$disconnect();
  });

  it("201 voi URL hop le", async () => {
    const res = await app.inject({
      method: "POST",
      url: "/api/links",
      payload: { url: "https://example.com" },
    });
    expect(res.statusCode).toBe(201);
    const body = JSON.parse(res.body);
    expect(body.slug).toMatch(/^[a-zA-Z0-9]{6}$/);
    expect(body.shortUrl).toBe(`https://beshort.ly/${body.slug}`);
  });

  it("400 voi URL xau", async () => {
    const res = await app.inject({
      method: "POST",
      url: "/api/links",
      payload: { url: "not-a-url" },
    });
    expect(res.statusCode).toBe(400);
    expect(JSON.parse(res.body).code).toBe("INVALID_URL");
  });

  it("400 khi thieu url", async () => {
    const res = await app.inject({
      method: "POST",
      url: "/api/links",
      payload: {},
    });
    expect(res.statusCode).toBe(400);
  });
});
