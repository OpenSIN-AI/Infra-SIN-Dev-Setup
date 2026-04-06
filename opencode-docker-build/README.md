# OpenCode CLI — Docker Setup

## Befehl 1: Einmalig (nur 1x pro Mac/VM)

Repo holen, Binary laden, Image bauen. Fertig.

```bash
rm -rf ~/Infra-SIN-Dev-Setup && git clone https://github.com/OpenSIN-AI/Infra-SIN-Dev-Setup.git && cd Infra-SIN-Dev-Setup/opencode-docker-build && chmod +x download-binary.sh && ./download-binary.sh && docker build -t oc .
```

## Befehl 2: Neue Maschine erstellen + öffnen

```bash
docker volume create oc-1-data && docker run -it -v oc-1-data:/root/.local/share/opencode --name oc-1 --entrypoint bash oc
```

Nummer hochzählen: `oc-2-data` / `oc-2`, `oc-3-data` / `oc-3`, ...

## Bestehende Maschine wieder öffnen

```bash
docker start -i oc-1
```

---

## Was ist im Image?

- **OpenCode CLI** v1.3.17 (native musl binary)
- **GitHub CLI**
- **oh-my-opencode** v3.11.2 → Subagenten: explore, librarian, etc.
- **opencode-antigravity-auth** v1.6.5-beta.0
- **opencode.json** mit qwen3.6-plus-free als Standardmodell

Jeder Container = eigenes Volume = eigene Identität = kein shared rate limit.
