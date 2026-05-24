# macOS Development Environment Setup

<p align="center">
<a href="https://github.com/OpenSIN-AI/Infra-SIN-Dev-Setup/blob/main/LICENSE">
<img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License" />
</a>
<a href="https://www.python.org/downloads/">
<img src="https://img.shields.io/badge/python-3.13-3776AB?logo=python&logoColor=white" alt="Python 3.13" />
</a>
<a href="https://brew.sh/">
<img src="https://img.shields.io/badge/homebrew-F0A84D?logo=homebrew&logoColor=black" alt="Homebrew" />
</a>
<a href="https://code.visualstudio.com/">
<img src="https://img.shields.io/badge/VS%20Code-007ACC?logo=visual-studio-code&logoColor=white" alt="VS Code" />
</a>
<a href="https://git-scm.com/">
<img src="https://img.shields.io/badge/git-%23F05032?logo=git&logoColor=white" alt="Git" />
</a>
<a href="https://nodejs.org/">
<img src="https://img.shields.io/badge/node.js-22 LTS-339933?logo=node.js&logoColor=white" alt="Node.js 22 LTS" />
</a>
<a href="https://bun.sh/">
<img src="https://img.shields.io/badge/bun-1.2+-f9f1df?logo=bun&logoColor=white" alt="Bun" />
</a>
<a href="https://docs.docker.com/docker-for-mac/">
<img src="https://img.shields.io/badge/docker-2496ED?logo=docker&logoColor=white" alt="Docker" />
</a>
<a href="https://github.com/cli/cli">
<img src="https://img.shields.io/badge/gh%20CLI-ff69b4?logo=github&logoColor=white" alt="GitHub CLI" />
</a>
</p>

<p align="center">
<a href="#quick-start">Quick Start</a> · <a href="#voraussetzungen">Voraussetzungen</a> · <a href="#tools">Tools</a> · <a href="#installation">Installation</a> · <a href="#konfiguration">Konfiguration</a> · <a href="#chrome-profile">Chrome Profile</a> · <a href="#opencode-stack">OpenCode Stack</a> · <a href="#alternativen">Alternativen</a> · <a href="#troubleshooting">Troubleshooting</a>
</p>

<p align="center">
<em>Dein Mac ist in 30 Minuten ready für OpenSIN-AI Development — mit Bun, n8n, Docker und allen A2A Agents.</em>
</p>

---

## Quick Start

<table>
<tr>
<td width="20%" align="center">
<strong>1. Xcode Tools</strong><br/><br/>
<code>xcode-select --install</code><br/><br/>
<img src="https://img.shields.io/badge/⏱️_2min-Blue?style=flat" />
</td>
<td width="20%" align="center">
<strong>2. Homebrew</strong><br/><br/>
<code>/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"</code><br/><br/>
<img src="https://img.shields.io/badge/⏱️_3min-Blue?style=flat" />
</td>
<td width="20%" align="center">
<strong>3. Dev Stack</strong><br/><br/>
<code>brew install git node bun python gh docker</code><br/><br/>
<img src="https://img.shields.io/badge/⏱️_5min-Blue?style=flat" />
</td>
<td width="20%" align="center">
<strong>4. OpenCode Stack</strong><br/><br/>
<code>gh repo clone OpenSIN-Code/Infra-SIN-OpenCode-Stack && cd upgraded-opencode-stack && ./install.sh</code><br/><br/>
<img src="https://img.shields.io/badge/⏱️_10min-Blue?style=flat" />
</td>
<td width="20%" align="center">
<strong>5. Global Brain</strong><br/><br/>
<code>node ~/.config/opencode/skills/global-brain/src/cli.js setup-hooks --project $(basename "$PWD") --project-root "$PWD" --agents-directive</code><br/><br/>
<img src="https://img.shields.io/badge/⏱️_2min-Blue?style=flat" />
</td>
</tr>
</table>

> [!TIP]
> Nach Homebrew-Installation: Die "Next steps" Ausgabe im Terminal beachten — oft muss Homebrew zum PATH hinzugefügt werden!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Voraussetzungen

| Anforderung       | Details                                    |
| :---------------- | :----------------------------------------- |
| **macOS Version** | macOS 13 (Ventura) oder höher              |
| **Hardware**      | Apple Silicon (M1/M2/M3/M4) oder Intel Mac |
| **Rechte**        | Administrator-Zugang (sudo)                |
| **Internet**      | Aktive Verbindung für Downloads            |

> [!NOTE]
> Apple Silicon (M1-M4) Macs sind empfohlen — bessere Performance für Node.js/n8n Workflows und Docker (Apple Silicon Build).

> [!IMPORTANT]
> **Intel Mac User:** Docker Desktop mit Apple Silicon Emulation ist langsamer. Wenn möglich, nutze einen M1/M2/M3/M4 Mac für bessere Performance.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Tools

Dieses Setup installiert folgende Tools:

| Tool               | Version | Beschreibung                                   | Link                                                   |
| :----------------- | :------ | :--------------------------------------------- | :----------------------------------------------------- |
| **Homebrew**       | Latest  | Paketmanager für macOS                         | [brew.sh](https://brew.sh)                             |
| **Git**            | 2.40+   | Versionskontrolle                              | [git-scm.com](https://git-scm.com)                     |
| **gh CLI**         | 2.60+   | GitHub CLI für PRs, Issues, Repos              | [cli.github.com](https://cli.github.com)               |
| **Node.js**        | 22 LTS  | JavaScript Runtime                             | [nodejs.org](https://nodejs.org)                       |
| **Bun**            | 1.2+    | Schneller Package Manager (NICHT npm!)         | [bun.sh](https://bun.sh)                               |
| **Python**         | 3.13    | Programmiersprache                             | [python.org](https://www.python.org)                   |
| **Docker Desktop** | Latest  | Container Runtime für lokale Tests             | [docker.com](https://docker.com)                       |
| **VS Code**        | Latest  | Code Editor                                    | [code.visualstudio.com](https://code.visualstudio.com) |
| **iTerm2**         | Latest  | Terminal Alternative (optional aber empfohlen) | [iterm2.com](https://iterm2.com)                       |
| **Raycast**        | Latest  | Spotlight Alternative (optional)               | [raycast.com](https://raycast.com)                     |

> [!IMPORTANT]
> **BUN STATT NPM!** npm ist permanent verbannt — es frisst 4-6 GB RAM und wird vom OOM-Killer gekillt. Nutze IMMER `bun install` und `bun run`!

<details>
<summary>Warum Bun statt npm?</summary>

| Kriterium               | npm               | Bun              |
| :---------------------- | :---------------- | :--------------- |
| RAM-Verbrauch           | 4-6 GB            | ~500 MB          |
| Install-Geschwindigkeit | Langsam           | 10-50x schneller |
| OOM-Killer              | Häufig            | Selten           |
| Lock-File               | package-lock.json | bun.lockb        |

</details>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Installation

### Phase 1: Xcode Command Line Tools

```bash
xcode-select --install
```

> [!NOTE]
> Dies öffnet einen Dialog — auf "Installieren" klicken und warten. Bei "Bereits installiert" einfach weitermachen.

### Phase 2: Homebrew installieren

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**Apple Silicon (M1/M2/M3/M4)额外 Schritt:**

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**Intel Mac:**

```bash
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

### Phase 3: Dev Tools installieren

```bash
brew install git node python bun gh wget curl openssl
```

### Phase 4: Docker Desktop installieren

```bash
brew install --cask docker
```

> [!TIP]
> Nach Docker Installation: Docker Desktop einmal starten und einloggen. Alternativ für Apple Silicon: **OrbStack** nutzen (schneller und ressourceneffizienter):
>
> ```bash
> brew install --cask orbstack
> ```

### Phase 5: VS Code installieren

```bash
brew install --cask visual-studio-code
```

> [!TIP]
> VS Code Extensions für OpenSIN-Stack:
>
> - `ms-python.python` (Python)
> - `esbenp.prettier-vscode` (Formatierung)
> - `github.copilot` (AI Copilot)
> - `redhat.vscode-yaml` (YAML)
> - `ms-vscode.powershell` (PowerShell)

### Phase 6: iTerm2 installieren (empfohlen)

```bash
brew install --cask iterm2
```

> [!NOTE]
> iTerm2 bietet bessere Split Panes, Search und Customization als das Standard-Terminal.

### Phase 7: Raycast installieren (optional)

```bash
brew install --cask raycast
```

> [!TIP]
> Raycast ersetzt Spotlight und bietet schnelle Actions, Clipboard History und Window Management.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Konfiguration

### Git Setup

```bash
# Git konfigurieren
git config --global user.name "Dein Name"
git config --global user.email "deine.email@example.com"
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global rebase.autoStash true
git config --global push.default current

# GitHub CLI autentifizieren
gh auth login
```

### GitHub CLI (gh) Setup

```bash
# GitHub autentifizieren (SSH oder HTTPS)
gh auth login

# SSH Key für GitHub generieren (falls noch nicht vorhanden)
ssh-keygen -t ed25519 -C "deine.email@example.com"

# Key zu SSH Agent hinzufügen
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Key anzeigen (für GitHub Settings → SSH Keys kopieren)
cat ~/.ssh/id_ed25519.pub
```

> [!IMPORTANT]
> Den öffentlichen Key (`id_ed25519.pub`) in **GitHub Settings → SSH and GPG Keys → New SSH Key** hinzufügen!

### Python Setup

```bash
# Python 3.13 Virtual Environment erstellen
python3 -m venv ~/.venv/opencode
source ~/.venv/opencode/bin/activate

#pip install opencode # falls benötigt
```

### Node.js/Bun Setup

```bash
# Bun als Standard-Paketmanager setzen
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Alias für Konsistenz
echo 'alias b="bun"' >> ~/.zshrc
echo 'alias bi="bun install"' >> ~/.zshrc
echo 'alias br="bun run"' >> ~/.zshrc
echo 'alias bt="bun test"' >> ~/.zshrc
source ~/.zshrc
```

### SSH Key für GitHub

```bash
# SSH Key generieren (falls noch nicht vorhanden)
ssh-keygen -t ed25519 -C "deine.email@example.com" -f ~/.ssh/id_ed25519 -N ""

# Key zu SSH Agent hinzufügen
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Key anzeigen (für GitHub Settings kopieren)
cat ~/.ssh/id_ed25519.pub
```

> [!IMPORTANT]
> Den öffentlichen Key (`id_ed25519.pub`) in **GitHub Settings → SSH and GPG Keys → New SSH Key** hinzufügen!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Chrome Profile

Für Browser Automation (Prolific, Surveys, etc.) werden Chrome Profile benötigt:

### Profil-Verzeichnis

| Profil           | Email                                 | Verwendung                            | Dokumentation                                           |
| :--------------- | :------------------------------------ | :------------------------------------ | :------------------------------------------------------ |
| **Geschäftlich** | info@zukunftsorientierte-energie.de   | Admin Console, Domain-Wide Delegation | [admin-profiles](./dev/docs/chrome/admin-profiles/)     |
| **Default**      | zukunftsorientierte.energie@gmail.com | Privat — NIEMALS für Admin!           | [private-profiles](./dev/docs/chrome/private-profiles/) |

### Chrome Profile Verzeichnis

```
~/Library/Application Support/Google/Chrome/
├── Default/              # Default Profil (zukunftsorientierte.energie@gmail.com)
├── Geschäftlich/         # Workspace Admin Profil (info@zukunftsorientierte-energie.de)
└── ...                   # Weitere Profile
```

> [!WARNING]
> **NIEMALS das falsche Profil für Admin-Aufgaben nutzen!** Immer "Geschäftlich" für Google Admin Console!

### Profile dokumentieren

Für jedes neue Chrome Profil eine Dokumentation erstellen:

```bash
# Beispiel: Profil-Dokumentation erstellen
mkdir -p ~/dev/docs/chrome/admin-profiles/info@zukunftsorientierte-energie.de
echo "# Chrome Profil: info@zukunftsorientierte-energie.de" > ~/dev/docs/chrome/admin-profiles/info@zukunftsorientierte-energie.de/README.md
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## OpenCode Stack

### upgraded-opencode-stack installieren

```bash
# Repository klonen (MIT GH CLI!)
gh repo clone OpenSIN-Code/Infra-SIN-OpenCode-Stack ~/dev/upgraded-opencode-stack
cd ~/dev/upgraded-opencode-stack

# Installation starten
./install.sh
```

### Global Brain / PCPM initialisieren (PFLICHT!)

> [!IMPORTANT]
> **OHNE Global Brain hat der Agent KEINE Erinnerung an frühere Sessions und funktioniert nicht richtig!**

```bash
# Global Brain Hooks installieren
node ~/.config/opencode/skills/global-brain/src/cli.js setup-hooks \
  --project $(basename "$PWD") \
  --project-root "$PWD" \
  --agents-directive

# Verification
ls -la .opencode/hooks/
```

### Serena MCP aktivieren

> [!NOTE]
> Serena MCP macht Coding-Leistungen weitaus effektiver! Muss nach der OpenCode Installation aktiviert werden.

```bash
# Serena MCP in der project-opencode.json oder globalen opencode.json aktivieren
# Prüfe ob Serena MCP verfügbar ist:
cat ~/.config/opencode/opencode.json | grep -i serena

# Falls nicht: Serena MCP installieren und aktivieren
```

### sin-sync ausführen (nach OCI VM Setup)

```bash
# Config auf OCI VM syncen (nach dem OCI Setup)
sin-sync
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Next Steps

Nach dem Setup:

1. **[OCI-dev-setup.md](./OCI-dev-setup.md)** — Oracle Cloud VM mit n8n, A2A-SIN-GitHub-Action und Box.com Storage aufsetzen
2. **[opencode-dev-setup.md](./opencode-dev-setup.md)** — OpenCode CLI konfigurieren und autentifizieren
3. **[upgraded-opencode-stack](https://github.com/OpenSIN-Code/Infra-SIN-OpenCode-Stack)** — `./install.sh` ausführen falls noch nicht done

> [!TIP]
> Für eine vollständige OCI VM mit n8n, A2A-SIN-GitHub-Action und Box.com Storage → folge `OCI-dev-setup.md` Schritt für Schritt.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Alternativen

### Ohne Homebrew (Minimal-Setup)

Falls Homebrew nicht installiert werden kann:

```bash
# Xcode Tools
xcode-select --install

# Git (vorinstalliert auf macOS)
git --version

# GitHub CLI von python.org oder direct
brew install gh # wenn brew verfügbar

# Python von python.org oder via brew
brew install python@3.13 # wenn brew verfügbar
```

### Docker Alternativen

**OrbStack** (schneller auf Apple Silicon):

```bash
brew install --cask orbstack
```

**Lima** (open-source, leicht):

```bash
brew install lima
limactl start default
```

### Für OpenSIN-AI spezifische Tools

```bash
# n8n (Workflow Automation) — läuft auf OCI VM
# Lokal nicht nötig — unsere n8n Workflows laufen auf der OCI VM

# opencode CLI — vom upgraded-opencode-stack
# Installation via: gh repo clone OpenSIN-Code/Infra-SIN-OpenCode-Stack && cd upgraded-opencode-stack && ./install.sh

# Box.com Storage — für Logs/Screenshots
# Via A2A-SIN-Box-Storage Service (room-09-box-storage)
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Troubleshooting

| Problem                                                         | Lösung                                                                                   |
| :-------------------------------------------------------------- | :--------------------------------------------------------------------------------------- |
| `brew: command not found`                                       | Homebrew nicht im PATH — Terminal neu starten oder `eval "$(brew shellenv)"`             |
| `xcode-select: error: command line tools are already installed` | Kein Problem — bereits installiert                                                       |
| `permission denied` bei Homebrew                                | `sudo chown -R $(whoami) /usr/local/share/zsh` oder `/opt/homebrew`                      |
| GitHub Push verlangt Passwort                                   | SSH Key nutzen statt HTTPS — `git remote set-url origin git@github.com:user/repo.git`    |
| VS Code "command not found"                                     | VS Code → Command Palette → "Shell Command: Install 'code' command in PATH"              |
| Python Version zu alt                                           | `brew install python@3.13` und alten Symlink aktualisieren                               |
| Docker startet nicht                                            | Docker Desktop starten und einloggen, oder `brew services restart docker`                |
| gh auth login funktioniert nicht                                | `gh auth status` prüfen, ggf. `gh auth logout` und erneut einloggen                      |
| `bun: command not found` nach Neustart                          | `export BUN_INSTALL="$HOME/.bun"` und `export PATH="$BUN_INSTALL/bin:$PATH"` in ~/.zshrc |

> [!WARNING]
> Bei OOM-Kill (Process killed): **NIEMALS npm nutzen!** Immer `bun install` verwenden! npm frisst 4-6 GB RAM.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Quick Reference

```bash
# Nachinstallation neuer Tools
brew install <tool>
brew install --cask <app>

# Updates
brew update && brew upgrade

# Alle installierten Tools anzeigen
brew list
brew list --cask

# Hilfe
brew help
man brew

# Docker
docker ps              # Laufende Container
docker ps -a           # Alle Container
docker images          # Alle Images

# GitHub CLI
gh repo list           # Repositories auflisten
gh issue list          # Issues auflisten
gh pr status           # Pull Request Status
```

---

## License

Distributed under the **MIT License**. See [LICENSE](LICENSE) for more information.

---

<p align="center">
<a href="https://opensin.ai">
<img src="https://img.shields.io/badge/🤖_Powered_by-OpenSIN--AI-7B3FE4?style=for-the-badge&logo=github&logoColor=white" alt="Powered by OpenSIN-AI" />
</a>
</p>
<p align="center">
<sub>Entwickelt vom <a href="https://opensin.ai"><strong>OpenSIN-AI</strong></a> Ökosystem – Enterprise AI Agents die autonom arbeiten.</sub><br/>
<sub>🌐 <a href="https://opensin.ai">opensin.ai</a> · 💬 <a href="https://opensin.ai/agents">Alle Agenten</a> · 🚀 <a href="https://opensin.ai/dashboard">Dashboard</a></sub>
</p>

<p align="right">(<a href="#readme-top">back to top</a>)</p>
