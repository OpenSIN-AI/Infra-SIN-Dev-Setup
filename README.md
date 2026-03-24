# dev-setup 🚀

Dieses Repository dokumentiert das Standard-Entwicklungssetup für macOS. Es enthält alle grundlegenden Tools, die für die Softwareentwicklung benötigt werden.

## Vorbereitungen

Bevor wir die eigentlichen Tools installieren, benötigen wir die grundlegenden Apple-Entwicklerwerkzeuge und einen Paketmanager.

### 1. Xcode Command Line Tools
Diese Tools stellen wichtige Befehle wie `make` oder den Apple-eigenen Git-Client zur Verfügung. Öffne das Terminal und gib ein:

```bash
xcode-select --install
```

### 2. Homebrew installieren
[Homebrew](https://brew.sh/) ist der unverzichtbare Paketmanager für macOS. Er erlaubt es, alle weiteren Programme ganz einfach über das Terminal zu installieren.

```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"
```
*(Wichtig: Folge nach der Installation den Anweisungen im Terminal, um Homebrew zu deinem PATH hinzuzufügen.)*

---

## Installation der Core-Tools

Mit Homebrew können wir nun die wichtigsten Werkzeuge in einem Rutsch installieren. 

### 1. Git, Python & Node.js (NPM)
NPM wird standardmäßig zusammen mit Node.js installiert. Führe folgenden Befehl im Terminal aus:

```bash
brew install git python node
```

### 2. Visual Studio Code (VS Code)
VS Code installieren wir als grafische Anwendung (Cask) ebenfalls über Homebrew:

```bash
brew install --cask visual-studio-code
```

---

## Setup überprüfen

Um sicherzustellen, dass alles korrekt installiert wurde, kannst du die Versionen der Tools im Terminal abfragen:

```bash
git --version
python3 --version
node --version
npm --version
```

---

## Nächste Schritte (Best Practices)

### Git konfigurieren
Setze deinen Namen und deine E-Mail-Adresse für deine Commits:

```bash
git config --global user.name "Dein Name"
git config --global user.email "deine.email@beispiel.de"
```

### Terminal anpassen (Optional)
Für einen besseren Workflow im Terminal empfiehlt sich die Installation von:
* [iTerm2](https://iterm2.com/) (Ein besseres Terminal für macOS)
* [Oh My Zsh](https://ohmyz.sh/) (Ein Framework zur Verwaltung der Zsh-Konfiguration)
