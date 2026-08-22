/**
 * File: src/server.ts — Entry (21_FILE_STRUCTURE:1)
 * Chay: npm run dev (tsx watch) hoac npm start (dist)
 */
import Fastify from "fastify";
import { linksRoutes } from "./features/links/links.route.js";

const app = Fastify({ logger: true });

await app.register(linksRoutes);

app.get("/health", async () => ({ status: "ok", version: "0.1.0" }));

const port = Number(process.env.PORT ?? 3000);
await app.listen({ port, host: "0.0.0.0" });
console.log(`BeShort listening on http://localhost:${port}`);
