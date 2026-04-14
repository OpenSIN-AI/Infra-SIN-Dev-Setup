# Project Rules
## 🚨 ABSOLUTES CI/CD VERBOT — KEINE GITHUB ACTIONS (PRIORITY -10.0 — HÖCHSTE REGEL, KEINE AUSNAHMEN) 🚨

**KEINE GITHUB ACTIONS FÜR CI/CD, DEPLOYMENT ODER AUTOMATION!**

- OpenSIN-AI nutzt **AUSSCHLIESSLICH A2A-SIN-GitHub-Action + n8n** für alle CI/CD, Deployment, Build, Test und Automation Tasks.
- GitHub Actions Workflows (`.github/workflows/*.yml`) sind **PERMANENT VERBOTEN**.
- Der n8n-Router auf der OCI VM (`92.5.60.87:5678`) ist unser zentrales Automation-Backend.
- A2A-SIN-GitHub-Action ist unser GitHub Event Listener und n8n Bridge.
- Wer GitHub Actions erstellt oder vorschlägt: **Protokollverstoß**.


*This file is automatically maintained by sin-brain. Project-specific rules will be listed here.*
