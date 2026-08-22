/**
 * File: src/db/client.ts
 * Feature: BeShort — Prisma client singleton (21_FILE_STRUCTURE:3)
 * Author: AI (tao-prompt) — 2026-08-22
 * WHY: Singleton de khong tao nhieu connection, chi noi nay import @prisma/client
 */
import { PrismaClient } from "@prisma/client";

export const prisma = new PrismaClient();
