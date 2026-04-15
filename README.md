<a name="readme-top"></a>

# Upgraded OpenCode Stack

<p align="center">
  <a href="https://github.com/Delqhi/upgraded-opencode-stack/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License" />
  </a>
  <a href="https://github.com/Delqhi/upgraded-opencode-stack/stargazers">
    <img src="https://img.shields.io/github/stars/Delqhi/upgraded-opencode-stack?style=social" alt="Stars" />
  </a>
  <a href="https://github.com/Delqhi/upgraded-opencode-stack/network/members">
    <img src="https://img.shields.io/github/forks/Delqhi/upgraded-opencode-stack?style=social" alt="Forks" />
  </a>
  <a href="https://github.com/Delqhi/upgraded-opencode-stack/last-commit">
    <img src="https://img.shields.io/github/last-commit/Delqhi/upgraded-opencode-stack" alt="Last Commit" />
  </a>
  <a href="https://www.python.org/downloads/">
    <img src="https://img.shields.io/badge/python-3.12+-3776AB?logo=python&logoColor=white" alt="Python" />
  </a>
  <a href="https://github.com/modelcontextprotocol">
    <img src="https://img.shields.io/badge/MCP-2.0-068A0A?logo=mcp" alt="MCP" />
  </a>
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> ·
  <a href="#features">Features</a> ·
  <a href="#architecture">Architecture</a> ·
  <a href="#skills">Skills</a> ·
  <a href="#commands">Commands</a> ·
  <a href="#providers">Providers</a> ·
  <a href="#deploy">Deploy</a> ·
  <a href="#contributing">Contributing</a>
</p>

<p align="center">
  <em>Clone. Install. Run. Dein komplettes OpenCode-Setup — auf jedem Mac identisch.</em>
</p>

---

## Quick Start

<table>
<tr>
<td width="33%" align="center">
<strong>1. Clone</strong><br/><br/>
<code>git clone Delqhi/upgraded-opencode-stack</code><br/><br/>
<img src="https://img.shields.io/badge/10s-Blue?style=flat" />
</td>
<td width="33%" align="center">
<strong>2. Install</strong><br/><br/>
<code>./install.sh</code><br/><br/>
<img src="https://img.shields.io/badge/2min-Blue?style=flat" />
</td>
<td width="33%" align="center">
<strong>3. Run</strong><br/><br/>
<code>opencode run "hello"</code><br/><br/>
<img src="https://img.shields.io/badge/Go!-Green?style=flat" />
</td>
</tr>
</table>

> [!TIP]
> Danach `.env` mit deinen API Keys befuellen — fertig. Exakt dasselbe Setup wie auf deinem Haupt-Mac.

---

## Features

| Capability | Description | Status |
|:---|:---|:---:|
| **Global-Brain (DPMA v4)** | Multi-Project Memory — Agenten vergessen nie wieder was sie gelernt haben | ✅ |
| **Local-Brain / GraphRAG** | Projekt-basiertes Plan-Gedächtnis mit Auto-Invalidation | ✅ |
| **OMOC Swarm** | 5-Agenten-Schwarm (Atlas, Hephaestus, Metis, Momus, Prometheus) | ✅ |
| **SIN-Zeus Fleet Commander** | GitHub Projects, Issues, Branches + Hermes Dispatch | ✅ |
| **44 Skills** | A2A Agent Builder, Deploy, Debug, Browser Automation, Image/Video Gen | ✅ |
| **4 Plugins** | Antigravity OAuth, Qwen OAuth, OpenRouter Proxy, OMO Framework | ✅ |
| **27 MCP Servers** | sin-telegrambot, sin-google-apps, sin-terminal, webauto-nodriver, ... | ✅ |
| **12 Custom Commands** | Swarm orchestration, Terminal orchestration, Zeus bootstrap | ✅ |
| **5 Provider** | Google Antigravity, OpenAI, OpenRouter, Qwen, Modal (GLM-5.1) | ✅ |
| **sin-sync Fleet Sync** | Mac → OCI VM → HF VM — identische Configs überall | ✅ |
| **Box.com Storage** | Unlimited cloud storage via A2A-SIN-Box-Storage (10GB free + auto-scale) | ✅ |

<details>
<summary>Full Tool Surface — Alle Komponenten im Detail</summary>

### Skills (44)
`anonymous`, `awesome-opensin-design`, `browser-crashtest-lab`, `check-my-dev-in-web`, `check-plan-done`, `cloudflare-deploy`, `create-a2a`, `create-a2a-mcp`, `create-a2a-sin-agent`, `create-a2a-sin-coder`, `create-a2a-team`, `create-auth-plugin`, `create-flow`, `create-github-account`, `create-github-app`, `create-telegrambot`, `doc`, `enterprise-deep-debug`, `enterprise-parallel-exploration`, `gen-image`, `gen-thumb`, `gen-thumbnail`, `gen-veo`, `gitlab-storage`, `imagegen`, `new-google-login`, `nvidia-3d-forge`, `nvidia-video-forge`, `omoc-plan-swarm`, `opencode-subagent-delegation`, `pdf`, `plan`, `preview`, `self-healer`, `seo-import`, `sin-bridge`, `sin-vision-colab`, `sora`, `sovereign-repo-governance`, `sovereign-research`, `thumbnail-optimizer`, `undelete-login-google`, `vercel-deploy`, `visual-repo`

### Plugins (4)
`opencode-antigravity-auth` (Token Rotation), `oh-my-opencode` (Framework), `opencode-qwen-auth` (Qwen OAuth), `opencode-openrouter-auth` (OpenRouter Proxy)

### MCP Servers (27)
`sin-document-forge`, `sin-telegrambot`, `tavily`, `canva`, `context7`, `chrome-devtools`, `linear`, `singularity`, `sin-google-apps`, `sin-server`, `sin-cloudflare`, `sin-passwordmanager`, `sin-research`, `sin-team-worker`, `sin-tiktok`, `sin-tiktok-shop`, `sin-terminal`, `webauto-nodriver`, `sin-authenticator`, `sin-github-issues`, `sin-oraclecloud-mcp`, `n8n-workflow-builder`, `sin-google-docs`, `sin-summary`, `sin-paragraph`, `simone-mcp`, `firecrawl`

</details>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Architecture

```mermaid
flowchart TB
    subgraph Clients["Clients"]
        OC[OpenCode CLI]
        AG[A2A Agents]
        SK[Custom Skills]
    end

    subgraph Transport["Transport Layer"]
        STD[MCP stdio]
        HTTP[HTTP/MCP]
    end

    subgraph Core["Core Stack"]
        CFG[opencode.json]
        PLG[5 Plugins]
        AGT[21 Agents]
    end

    subgraph Storage["Storage"]
        BO[Box.com Storage]
        DP[DPMA v4 Brain]
    end

    subgraph Fleet["Fleet"]
        MAC[Mac]
        OCI[OCI VM]
        HF[HF VMs]
    end

    OC --> STD
    AG --> HTTP
    SK --> STD
    STD --> CFG
    HTTP --> CFG
    CFG --> PLG
    CFG --> AGT
    PLG --> BO
    AGT --> DP
    CFG --> SYNC[sin-sync]
    SYNC --> MAC
    SYNC --> OCI
    SYNC --> HF

    classDef clientClass fill:#e1f5fe,stroke:#01579b,stroke-width:2px
    classDef transportClass fill:#fff3e0,stroke:#e65100,stroke-width:2px
    classDef coreClass fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px
    classDef storageClass fill:#fce4ec,stroke:#880e4f,stroke-width:2px
    classDef fleetClass fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px

    class OC,AG,SK clientClass
    class STD,HTTP transportClass
    class CFG,PLG,AGT coreClass
    class GL,DP storageClass
    class MAC,OCI,HF fleetClass
```

For detailed architecture documentation see [docs/oci-vm-architecture.md](docs/oci-vm-architecture.md), [FIXES_2026-04-11.md](FIXES_2026-04-11.md), and [docs/operations/system-directives-guide.md](docs/operations/system-directives-guide.md) (System Directives & Brain Sync Enforcer).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Skills

| Skill | Zweck |
|-------|-------|
| `create-a2a` | A2A Agent erstellen |
| `create-a2a-mcp` | A2A MCP Server erstellen |
| `create-a2a-sin-coder` | A2A Coder Agent bootstrappen |
| `create-a2a-team` | SIN A2A Team Manager erstellen |
| `create-auth-plugin` | OpenCode Auth Plugin bauen |
| `create-flow` | Interaktiver Flow Builder (SIN-InkogniFlow) |
| `new-google-login` | Robustes Google-Login via Chrome-CDP |
| `create-telegrambot` | Telegram Bot erstellen/deployen |
| `cloudflare-deploy` | Cloudflare Deployment |
| `vercel-deploy` | Vercel Deployment |
| `sin-bridge` | OpenSIN Bridge Chrome Extension |
| `enterprise-deep-debug` | Enterprise Debugging |
| `sovereign-repo-governance` | Repo Governance |
| `anonymous` | Browser Automation (webauto-nodriver-mcp) |
| `imagegen` | Bild-Generierung via Gemini |
| `nvidia-video-forge` | Video-Generierung via NVIDIA |

*Vollständige Liste: 29 Skills installiert*

---

## Commands

| Command | Zweck |
|---------|-------|
| `omoc-jam` | Collaborative Swarm Jam |
| `omoc-max` | OMOC MAX best-of-n |
| `omoc-status` | Swarm Members anzeigen |
| `sin-terminal-orchestrate` | SIN-Terminal — parallele Sessions steuern |
| `sin-zeus-bootstrap` | GitHub Project + Issue Pool aus Zeus Plan |

<details>
<summary>Alle 13 Commands</summary>

| Command | Zweck |
|---------|-------|
| `omoc-swarm-create` | Swarm erstellen/registrieren |
| `omoc-swarm-discover` | Swarm aus Session-Titeln entdecken |
| `omoc-jam` | Collaborative Swarm Jam |
| `omoc-max` | OMOC MAX best-of-n |
| `omoc-status` | Swarm Members anzeigen |
| `omoc-autostart` | Auto-bind Swarm + JAM Guidance |
| `sin-terminal-orchestrate` | SIN-Terminal — parallele Sessions steuern |
| `sin-terminal-orchestrate-status` | Terminal Orchestration Status |
| `sin-terminal-orchestrate-delegate` | Follow-up Prompt delegieren |
| `sin-terminal-orchestrate-stop` | Alle Sessions stoppen |
| `sin-zeus-bootstrap` | GitHub Project + Issue Pool aus Zeus Plan |
| `sin-zeus-hermes` | Hermes Dispatch Payloads generieren |
| `sin-zeus-status` | Zeus Control-Plane Status |

</details>

---

## Providers
| Provider | Modelle |
|----------|---------|
| **google** (Antigravity) | `antigravity-claude-sonnet-4-6`, `antigravity-claude-opus-4-6-thinking`, `antigravity-gemini-3.1-pro`, `antigravity-gemini-3-flash` |
| **openai** | `gpt-5.4`, `gpt-5.4-mini` via OCI Proxy (92.5.60.87:4100) |
| **openrouter** | Qwen 3.6 Plus, DeepSeek V3/R1, Gemini 2.5 Flash, Llama 4 Maverick, Phi-4 (free) |
| **qwen** | `qwen/coder-model` — Qwen 3.6 Plus (OAuth, 2000/day free) |
| **modal** | `glm-5.1-fp8` — GLM 5.1 FP8 (via OCI Token Pool) |

---

## Deploy

| Methode | Kommando | Zweck |
|:---|:---|:---|
| **Local** | `./install.sh` | Mac Setup — 1:1 Kopie des Setups |
| **OCI VM** | `sin-sync` | Config Sync Mac → OCI VM (92.5.60.87) |
| **HF VM** | `sin-sync` | Config Sync Mac → HF Spaces |
| **Lightning AI** | `sin-sync` | Config Sync Mac → Lightning AI VM |

> [!IMPORTANT]
> `sin-sync` muss nach JEDER Aenderung an `opencode.json` ausgefuehrt werden. Auth-Dateien werden automatisch ausgeschlossen.

<details>
<summary>Environment Variables</summary>

| Variable | Purpose | Required |
|:---|:---|:---:|
| `NVIDIA_API_KEY` | NVIDIA NIM | ✅ |
| `GOOGLE_API_KEY` | Gemini Direct API | ✅ |
| `OPENROUTER_API_KEY` | OpenRouter | ✅ |
| `OPENAI_API_KEY` | OpenAI (via Proxy) | ✅ |
| `TELEGRAM_BOT_TOKEN` | sin-telegrambot | |
| `N8N_BASE_URL` | n8n URL | |
| `N8N_API_KEY` | n8n API Key | |
| `OCI_VM_HOST` | OCI VM Host | |
| `OCI_VM_USER` | OCI VM User | |
| `SUPABASE_URL` | Supabase | |
| `SUPABASE_KEY` | Supabase Key | |

</details>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Repo Struktur

```
upgraded-opencode-stack/
├── install.sh              # Haupt-Installer
├── opencode.json           # OpenCode Config (Provider, Modelle, MCPs, Agenten)
├── AGENTS.md               # Globale Agent-Regeln (inkl. PARALLEL-EXPLORATION MANDATE)
│
├── oh-my-sin.json          # 🆕 Zentrales A2A Team Register (alle Teams + Manager)
├── oh-my-openagent.json    # Subagenten-Modell-Konfiguration (explore, librarian, etc.)
├── oh-my-opencode.json     # Identisch mit oh-my-openagent.json (gesynced)
├── my-sin-team-code.json   # 🆕 Team Coding Agenten + Modelle
├── my-sin-team-worker.json # 🆕 Team Worker Agenten + Modelle
├── my-sin-team-infrastructure.json # 🆕 Team Infra Agenten + Modelle
│
├── .env.example            # API Key Template
├── llms.txt                # AI Discoverability
├── llms-full.txt           # Full Context for AI Agents
├── CONTRIBUTING.md         # How to contribute
├── SECURITY.md             # Security policy
├── SUPPORT.md              # Where to get help
├── bin/                    # 11 CLI Tools
├── skills/                 # 29 Skills
├── plugins/                # 5+ Plugins (lokal)
├── agents/                 # Agent-Definitionen
├── commands/               # 13 Custom Commands
├── scripts/                # 17 Scripts
├── docs/                   # OCI VM Architecture + Fixes
├── hooks/                  # Git Hooks
├── templates/              # JSON Schemas
└── vendor/                 # Vendored Dependencies
```

---

## Agenten-Konfigurationsdateien

Dieses Repo verwaltet **7 Konfigurationsdateien** fuer die gesamte A2A-Flotte:

| Datei | Zweck | Inhalt |
|:---|:---|:---|
| `opencode.json` | **Haupt-Config** — Provider, Modelle, MCPs, Agenten, Commands | Deine sichtbaren Agenten (SIN-Zeus, Sisyphus, etc.) |
| `oh-my-sin.json` | **Zentrales Team Register** — alle A2A Teams klassifiziert | Team-Manager, Config-Dateien, Default-Modelle |
| `oh-my-openagent.json` | **Subagenten-Modelle** — interne Agenten bei Delegation | explore, librarian, oracle, etc. + Fallback-Ketten |
| `oh-my-opencode.json` | Identisch mit oh-my-openagent.json (auto-gesynced) | Wird vom OHO Plugin gelesen |
| `my-sin-team-code.json` | **Team Coding** — Entwickler-Flotte | Zeus, Simone, Frontend, Backend, Fullstack |
| `my-sin-team-worker.json` | **Team Worker** — autonome Worker | Prolific, Freelancer, Survey |
| `my-sin-team-infrastructure.json` | **Team Infra** — DevOps-Flotte | Deploy, Monitoring, Security |

### Team-Register Architektur

```
oh-my-sin.json (Zentrales Register)
    ├── team-code → my-sin-team-code.json
    ├── team-worker → my-sin-team-worker.json
    └── team-infrastructure → my-sin-team-infrastructure.json
```

Jede Team-Config definiert:
- **Agenten** mit spezifischen Modellen und Fallback-Ketten
- **Kategorien** fuer Task-spezifische Modell-Auswahl
- **Rollen** und Beschreibungen pro Agent

### PARALLEL-EXPLORATION MANDATE

Bei grossen Codebases (100k+ Zeilen) MUESSEN Agenten **5-10 parallele explore + 5-10 librarian-Agenten** starten:

```
task(subagent_type="explore", run_in_background=true, load_skills=[], description="Find APIs", ...)
task(subagent_type="explore", run_in_background=true, load_skills=[], description="Find Services", ...)
task(subagent_type="librarian", run_in_background=true, load_skills=[], description="Framework Docs", ...)
// ... 9 weitere parallele Agenten
```

Siehe `AGENTS.md` → `PARALLEL-EXPLORATION MANDATE (PRIORITY -4.5)` fuer Details.

---

## Changelog

### v2.2.1 (2026-04-14)
- **Box.com Storage** — Replaced deprecated GitLab LogCenter with A2A-SIN-Box-Storage service
- Updated storage default globally in AGENTS.md (Box Storage Mandate)
- Added `box_storage.py` compatibility layer, deprecated `gitlab_logcenter.py`
- Updated Infra-SIN-Docker-Empire: `room-09-box-storage` added, `room-07-gitlab-storage` removed
- All agents must migrate to Box Storage API before 2026-05-01

### v2.2.0 (2026-04-14)
- **Step 3.5 Flash** — explore/librarian nutzen jetzt nvidia-nim/stepfun-ai/step-3.5-flash
- **PARALLEL-EXPLORATION MANDATE** — 5-10 parallele explores fuer grosse Codebases
- **Full Fallback Chains** — restored fuer explore/librarian (6 Modelle pro Agent)
- **Providers aktualisiert** — glm-5.1-fp8, gpt-5.4-mini, qwen-3.5-flash, Lightning AI VM

### v2.1.0 (2026-04-14)
- Enterprise Visual README overhaul (badges, diagrams, llms.txt)
- GitLab Storage skill added (infinite storage via auto-rotating repos) - NOW DEPRECATED
- OCI VM architecture documented
- .so temp file leak root cause fixed + systemd timer added
- Vision model removed from Qwen config (no longer supported)
- reasoningEffort removed from all Qwen agents (not supported)

### v2.0.0 (2026-04-12)
- Qwen OAuth plugin fully fixed and integrated
- Global-Brain DPMA v4 hooks installed

### v1.0.0 (2026-04-11)
- Initial release
- 29 Skills, 5 Plugins, 21 Agents, 11 CLI Tools

---

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run `./install.sh` to verify
5. Commit (`git commit -m 'Add amazing feature'`)
6. Push (`git push origin feature/amazing-feature`)
7. Open a Pull Request

> [!NOTE]
> Nach jeder Aenderung an `opencode.json` MUSS `sin-sync` ausgefuehrt werden.

---

## License

MIT. See [LICENSE](LICENSE) for details.

---

<p align="center">
  <sub>Built by <a href="https://github.com/OpenSIN-AI">OpenSIN-AI Fleet</a></sub>
</p>

<p align="right">(<a href="#readme-top">back to top</a>)</p>
