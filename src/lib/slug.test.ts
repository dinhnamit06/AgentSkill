import { describe, it, expect } from "vitest";
import { generateSlug } from "./slug.js";

describe("generateSlug", () => {
  it("tao slug 6 ky tu a-zA-Z0-9", () => {
    const slug = generateSlug();
    expect(slug).toMatch(/^[a-zA-Z0-9]{6}$/);
  });

  it("khong trung khi goi 1000 lan", () => {
    const set = new Set(Array.from({ length: 1000 }, () => generateSlug()));
    expect(set.size).toBe(1000);
  });
});
