# 19 â€” PLUGIN & MCP: 1 server cho má»i IDE/agent (Codex, Antigravity, OpenCode, Cursor, Windsurf)

> **Káº¿t luáº­n:** KhÃ´ng cáº§n viáº¿t plugin riÃªng cho tá»«ng IDE. Viáº¿t **1 MCP server (TS)** â€” má»i agent há»— trá»£ MCP Ä‘á»u gá»i Ä‘Æ°á»£c. OpenCode/Cursor/Windsurf/Codex/Antigravity Ä‘á»u Ä‘Ã£ há»— trá»£ MCP.

## Kiáº¿n trÃºc

```
be-short/mcp-server/          # MCP server TS â€” nguá»“n chÃ¢n lÃ½
  â”œâ”€â”€ src/index.ts            # stdio transport, expose 5 tools
  â””â”€â”€ src/tools/*.ts          # biz, spec, prompt, review, handover

Any IDE/agent  â”€â”€MCP stdioâ”€â”€â–º  mcp-server  â”€â”€â–º  docs/ (BIZ/SPEC/PROMPT/REVIEW)
  Codex         config.toml      5 tools       Ä‘á»c/ghi file trong repo
  Antigravity   mcp.json
  OpenCode      opencode.json
  Cursor        .cursor/mcp.json
  Windsurf      .windsurf/mcp.json
  Claude        claude_desktop_config.json
```

**Táº¡i sao MCP thay vÃ¬ plugin native?**
* Plugin native: má»—i IDE 1 SDK, 1 store, 1 ngÃ´n ngá»¯ â†’ 5x cÃ´ng sá»©c.
* MCP: 1 chuáº©n má»Ÿ (Anthropic), má»i agent má»›i Ä‘á»u há»— trá»£ â†’ 1x cÃ´ng sá»©c, auto tÆ°Æ¡ng thÃ­ch IDE ra máº¯t sau.

## 5 tools MCP (map tháº³ng vÃ o workflow 5 pha)

| Tool | Viá»‡c | Input | Output | Gá»i khi |
|------|------|-------|--------|---------|
| `vibe_biz` | lay-yeu-cau â€” há»i Socratic â†’ sinh BIZ | `idea: string` | `BIZ-xxx.md` path + 5 cÃ¢u há»i | Pha 2 |
| `vibe_spec` | type-first â†’ sinh SPEC | `bizPath: string` | `SPEC-xxx.md` + zod types | Pha 2 |
| `vibe_prompt` | tao-prompt â†’ sinh PROMPT 6 khá»‘i | `specPath: string, taskName: string` | `PROMPT-xxx.md` | Pha 3 |
| `vibe_review` | 5-axis review | `prPath: string` | `REVIEW-xxx.md` + findings | Pha 4 |
| `vibe_handover` | checklist bÃ n giao | `version: string` | `12_HANDOVER` report | Pha 5 |

Má»—i tool **Ä‘á»c `docs/_meta/PROJECT_CONTEXT.md`** trÆ°á»›c, thiáº¿u thÃ¬ tráº£ `MISSING_REQUIREMENT` báº¯t user Ä‘iá»n â€” Ä‘Ãºng `12_BAO_MAT.md:1` (há»i consent trÆ°á»›c khi fetch GitHub/API).

## CÃ i cho tá»«ng IDE (1 dÃ²ng)

**OpenCode:**
```json
// opencode.json
{ "mcp": { "vibe-coding": { "command": "node", "args": ["./mcp-server/dist/index.js"] } } }
```

**Codex (codex CLI):**
```toml
# ~/.codex/config.toml
[mcp_servers.vibe-coding]
command = "node"
args = ["C:/path/to/beshort/mcp-server/dist/index.js"]
```

**Antigravity / Cursor / Windsurf:**
```json
// .cursor/mcp.json  hoáº·c  ~/.config/antigravity/mcp.json
{ "mcpServers": { "vibe-coding": { "command": "node", "args": ["./mcp-server/dist/index.js"] } } }
```

**Claude Desktop:**
```json
// claude_desktop_config.json
{ "mcpServers": { "vibe-coding": { "command": "node", "args": ["./mcp-server/dist/index.js"] } } }
```

## Báº£o máº­t

MCP server **khÃ´ng tá»± Ä‘á»c** GitHub/API â€” tool nÃ o cáº§n external sáº½ tráº£ `NEED_CONSENT: {ask: "Báº¡n cho GitHub URL?"}` Ä‘á»ƒ agent há»i user trÆ°á»›c (`12_BAO_MAT.md:1`).

## Lá»™ trÃ¬nh

* **v0.1 (hiá»‡n táº¡i):** Scaffold `mcp-server/` + 5 tools stub, cháº¡y `npm run mcp:build` lÃ  má»i IDE gá»i Ä‘Æ°á»£c.
* **v0.2:** ThÃªm `npm publish` â†’ `npx vibe-coding-mcp` cho cÃ i 1 lá»‡nh.
* **v0.3:** Plugin store native (náº¿u cáº§n UI): OpenCode plugin `opencode plugin add vibe-coding`.

---
*Chi tiáº¿t scaffold: `mcp-server/package.json:1` vÃ  `mcp-server/src/index.ts:1`.*

