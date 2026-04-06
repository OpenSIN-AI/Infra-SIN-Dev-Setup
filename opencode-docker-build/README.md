# OpenCode CLI — Docker Setup

## Docker installieren

Stelle sicher, dass Docker Desktop auf deinem Mac M1 installiert und läuft.

## Dockerfile erstellen

Erstelle eine neue Datei namens `Dockerfile` in einem leeren Verzeichnis auf deinem Mac mit folgendem Inhalt:

```dockerfile
FROM alpine AS base

# Installiere notwendige Abhängigkeiten, einschließlich git und curl für gh cli
# Deaktiviert den Laufzeit-Transpiler-Cache in Docker-Containern standardmäßig.
# Bei kurzlebigen Containern ist der Cache nicht nützlich
ARG BUN_RUNTIME_TRANSPILER_CACHE_PATH=0
ENV BUN_RUNTIME_TRANSPILER_CACHE_PATH=${BUN_RUNTIME_TRANSPILER_CACHE_PATH}
RUN apk add --no-cache libgcc libstdc++ ripgrep git curl bash

# Installiere GitHub CLI
RUN apk add --no-cache github-cli

FROM base AS build-amd64
COPY dist/opencode-linux-x64-baseline-musl/bin/opencode /usr/local/bin/opencode

FROM base AS build-arm64
COPY dist/opencode-linux-arm64-musl/bin/opencode /usr/local/bin/opencode

ARG TARGETARCH
FROM build-${TARGETARCH}
RUN opencode --version
ENTRYPOINT ["opencode"]
```

## OpenCode Binary herunterladen

Lade das OpenCode Binary für Linux ARM64 von der OpenCode Releases-Seite herunter. Suche die Datei, die `opencode-linux-arm64-musl` im Namen hat (z.B. `opencode-linux-arm64-musl.tar.gz`), entpacke sie und platziere das opencode Binary in einem Unterverzeichnis `dist/opencode-linux-arm64-musl/bin/` relativ zu deinem Dockerfile.

Dein Verzeichnis sollte dann so aussehen:

```
.
├── Dockerfile
└── dist/
    └── opencode-linux-arm64-musl/
        └── bin/
            └── opencode
```

## Docker Image bauen

Öffne dein Terminal, navigiere zu dem Verzeichnis, in dem sich dein Dockerfile befindet, und führe den folgenden Befehl aus, um das Docker-Image zu bauen:

```bash
docker build --platform linux/arm64 -t opencode-cli-gh-m1 .
```

Der Image-Name ist hier `opencode-cli-gh-m1`.

## Docker Container starten und OpenCode CLI verwenden

Um sicherzustellen, dass jeder Container eine komplett separate OpenCode CLI-Maschine mit eigenen ID-Daten ist, solltest du bei jedem Start eines neuen Containers entweder ein neues, isoliertes Docker-Volume verwenden oder keine persistenten Speicher mounten.

### a. Einmalige Nutzung (Daten gehen nach Beenden verloren)

```bash
docker run -it opencode-cli-gh-m1 bash
```

Innerhalb des Containers kannst du dann `opencode --version` und `gh --version` ausführen, um die Installation zu überprüfen.

### b. Nutzung mit persistenten, aber isolierten Daten (empfohlen für separate "Maschinen")

Um sicherzustellen, dass jeder deiner "OpenCode CLI Maschinen"-Container eigene, separate ID-Daten hat, aber diese Daten auch über das Beenden des Containers hinaus bestehen bleiben, erstelle für jeden Container ein eigenes, benanntes Docker-Volume.

**Für deinen ersten Container:**

```bash
docker volume create opencode-machine-1-data
docker run -it -v opencode-machine-1-data:/root/.local/share/opencode --name opencode-machine-1 opencode-cli-gh-m1 bash
```

**Für einen zweiten, komplett separaten Container:**

```bash
docker volume create opencode-machine-2-data
docker run -it -v opencode-machine-2-data:/root/.local/share/opencode --name opencode-machine-2 opencode-cli-gh-m1 bash
```

Jeder Container (`opencode-machine-1`, `opencode-machine-2` usw.) wird sein eigenes, dediziertes Volume (`opencode-machine-1-data`, `opencode-machine-2-data`) verwenden, um OpenCode-spezifische Daten zu speichern. Dadurch sind die Installationen vollständig voneinander isoliert, obwohl sie dasselbe Basis-Image verwenden.

## OpenCode CLI Standardmodell setzen

Um das Standardmodell in der OpenCode CLI auf `opencode/qwen3.6-plus-free` zu setzen, musst du dies innerhalb des laufenden Docker-Containers tun. OpenCode speichert seine Konfiguration in einer `opencode.json` Datei. Du kannst dies über die CLI-Befehle oder durch direkte Bearbeitung der Konfigurationsdatei tun.

Nachdem du den Container gestartet hast (z.B. `docker run -it opencode-cli-gh-m1 bash`), führe im Container folgende Befehle aus:

```bash
opencode config set model opencode/qwen3.6-plus-free
```

Dies setzt das Standardmodell für die OpenCode CLI innerhalb dieses spezifischen Containers. Jede deiner separaten "Maschinen" (Container mit eigenen Volumes) würde dieses Modell standardmäßig verwenden, wenn du den Befehl entsprechend ausführst.

Zusätzlich zum Modell kannst du auch andere Provider (Anbieter) verbinden, wie in AI Agent Configuration and Workflows und Core Application Architecture and Services erwähnt. Die SettingsProviders Komponente (`packages/app/src/components/settings-providers.tsx`) zeigt, wie verschiedene Provider verbunden werden können, entweder über API-Schlüssel oder über die Konfigurationsdatei. Die Provider-Informationen werden vom `useProviders` Hook aus dem globalen Synchronisierungs-Kontext (`packages/app/src/hooks/use-providers.ts`, `packages/app/src/context/global-sync.tsx`) abgerufen.
