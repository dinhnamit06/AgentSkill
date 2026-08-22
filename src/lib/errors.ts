/**
 * File: src/lib/errors.ts
 * Feature: BeShort — AppError chuan (12_BAO_MAT S1)
 * Spec: SPEC-001 — khong throw string, tra {error, code}
 * Author: AI (tao-prompt PROMPT-001) + human review — 2026-08-22
 * WHY: Dung AppError de FE biet code de hien thi, log khong lo stack trace
 */
export class AppError extends Error {
  constructor(
    public code: string,
    public status: number,
    message: string,
  ) {
    super(message);
    this.name = "AppError";
  }
}
