# OpenSIN Cloud Storage — Box.com & Google Drive

> **OpenSIN Storage Architecture** — Multi-provider cloud storage for autonomous AI agents

**Updated:** 2026-04-14 | **Status:** Active | **Owner:** SIN-Zeus

---

## Overview

OpenSIN nutzt **Box.com** (10 GB free) als primären Cloud-Storage für alle Dateien die öffentlich erreichbar sein müssen, und **Google Drive** (15 GB free) als sekundäre Option. GitLab Storage wurde abgelöst.

### Storage Providers

| Provider | Free Storage | Purpose | URL |
|----------|-------------|---------|-----|
| **Box.com** | 10 GB | Primär — Public Files + Cache/Logs | https://app.box.com |
| **Google Drive** | 15 GB | Sekundär — Backup + User Data | https://drive.google.com |

---

## Box.com Storage

### Public Files Ordner
**Zweck:** Alle Dateien die **öffentlich erreichbar** sein müssen (Logos, Bilder, Dokumente, Media)

| Folder | Shared Link | Content |
|--------|------------|---------|
| `/OpenSIN-Public` | https://app.box.com/s/1st624o9eb5xdistusew5w0erb8offc7 | Public assets (Logos, Screenshots, Docs) |

### Cache Ordner
**Zweck:** Logs, Cache, Debug-Artefakte, temporäre Dateien — alles was NICHT öffentlich sein muss

| Folder | Shared Link | Content |
|--------|------------|---------|
| `/Cache` | https://app.box.com/s/9s5htoefw1ux9ajaqj656v9a02h7z7x1 | Logs, Cache, Temp Files, Debug Artifacts |

### Box.com als Object Storage nutzen

Box.com kann als **öffentlich erreichbarer Object Storage** für OpenSIN genutzt werden:

```bash
# Box.com Shared Link Format für direkten Download
# https://app.box.com/shared/static/{SHARE_ID}

# Dateien hochladen via Box CLI
brew install box-cli
box login
box files:upload ./screenshot.png --parent-folder-id FOLDER_ID

# Oder via Box API mit Developer Token
curl -X POST "https://upload.box.com/api/2.0/files/content" \
  -H "Authorization: Bearer DEVELOPER_TOKEN" \
  -F "attributes={\"name\":\"file.png\",\"parent\":{\"id\":\"0\"}}" \
  -F "file=@file.png"
```

### Onboarding: Box Account erstellen

Jeder OpenSIN User MUSS beim Onboarding einen Box.com Account anlegen:

1. **Registrieren:** https://www.box.com/signup/ (Free Plan = 10 GB)
2. **Ordner erstellen:**
   - `/OpenSIN-Public` → Für alle öffentlichen Dateien
   - `/Cache` → Für Logs, Cache, temporäre Dateien
3. **Sharing aktivieren:**
   - Rechtsklick auf Ordner → Share → "People with the link" → "Can view"
   - Link kopieren und in `.env` speichern
4. **Developer Token erstellen (optional):**
   - https://app.box.com/developers/console
   - Custom App erstellen → Server Authentication (JWT)
   - Developer Token generieren für API-Zugriff

### Empfehlungen für User

| Use Case | Empfohlener Storage | Warum |
|----------|-------------------|-------|
| Öffentliche Dateien (Logos, Bilder) | **Box.com** | Direkte öffentliche Links |
| Logs & Cache | **Box.com** | Automatisches Cleanup möglich |
| User Documents (15 GB+) | **Google Drive** | Mehr Speicher (15 GB vs 10 GB) |
| Sensitive Daten | **Google Drive** | Bessere Zugriffskontrolle |

---

## Google Drive Storage (Alternative)

### Setup

```bash
# Google Drive via rsync
brew install gdrive
gdrive list
gdrive upload --parent FOLDER_ID ./file.png

# Oder via Google Drive API
# Siehe: https://developers.google.com/drive/api
```

### Onboarding: Google Drive einrichten

1. **Google Account:** Vorhanden (jeder Gmail = 15 GB)
2. **Ordner erstellen:** `/OpenSIN-Storage`
3. **Freigabe:** "Anyone with the link" → "Viewer"
4. **Service Account (optional):** Für automatischen Zugriff

---

## Migration von GitLab Storage

### Was migriert werden muss:

| Alt (GitLab) | Neu (Box.com) | Action |
|-------------|--------------|--------|
| `gitlab_logcenter.py` uploads | Box.com API Uploads | Script anpassen |
| GitLab Storage Service (room-07) | Box.com Public Folder | docker-compose.yml anpassen |
| LogCenter Repos | Box.com `/Cache` Ordner | Redirect einrichten |

### Migration Script

```bash
#!/bin/bash
# migrate-gitlab-to-box.sh
# Migriert alle Dateien von GitLab LogCenter zu Box.com

BOX_FOLDER_ID="${BOX_PUBLIC_FOLDER_ID}"
BOX_TOKEN="${BOX_DEVELOPER_TOKEN}"

for file in ./gitlab-exports/*; do
  echo "Uploading: $file"
  curl -X POST "https://upload.box.com/api/2.0/files/content" \
    -H "Authorization: Bearer $BOX_TOKEN" \
    -F "attributes={\"name\":\"$(basename $file)\",\"parent\":{\"id\":\"$BOX_FOLDER_ID\"}}" \
    -F "file=@$file"
done
```

---

## Integration in OpenSIN Agenten

### Box Storage für A2A Agenten

Jeder A2A Agent der Dateien speichern/laden muss, nutzt Box.com:

```python
import requests

BOX_TOKEN = os.getenv("BOX_DEVELOPER_TOKEN")
BOX_FOLDER_ID = os.getenv("BOX_PUBLIC_FOLDER_ID")

def upload_to_box(file_path, filename):
    """Upload file to Box.com public folder"""
    url = "https://upload.box.com/api/2.0/files/content"
    headers = {"Authorization": f"Bearer {BOX_TOKEN}"}
    attributes = {"name": filename, "parent": {"id": BOX_FOLDER_ID}}
    
    with open(file_path, "rb") as f:
        response = requests.post(
            url,
            headers=headers,
            data={"attributes": json.dumps(attributes)},
            files={"file": f}
        )
    return response.json()

def get_public_url(file_id):
    """Get public shared link for a Box file"""
    url = f"https://api.box.com/2.0/files/{file_id}"
    headers = {"Authorization": f"Bearer {BOX_TOKEN}"}
    response = requests.get(url, headers=headers)
    return response.json().get("shared_link", {}).get("url", "")
```

### Box Storage in docker-compose

```yaml
# Box Storage Agent
agent-box-storage:
  image: sin-box-storage:latest
  container_name: agent-box-storage
  restart: unless-stopped
  environment:
    - BOX_DEVELOPER_TOKEN=${BOX_DEVELOPER_TOKEN}
    - BOX_PUBLIC_FOLDER_ID=${BOX_PUBLIC_FOLDER_ID}
    - BOX_CACHE_FOLDER_ID=${BOX_CACHE_FOLDER_ID}
  networks:
    haus-netzwerk:
      ipv4_address: 172.20.0.107
  ports:
    - "8099:8099"
  healthcheck:
    test: ["CMD", "curl", "-f", "http://127.0.0.1:8099/health"]
```

---

## .env Variablen

```bash
# Box.com Storage
BOX_DEVELOPER_TOKEN=
BOX_PUBLIC_FOLDER_ID=
BOX_CACHE_FOLDER_ID=

# Google Drive Storage (optional)
GOOGLE_DRIVE_CLIENT_ID=
GOOGLE_DRIVE_CLIENT_SECRET=
GOOGLE_DRIVE_FOLDER_ID=
GOOGLE_SERVICE_ACCOUNT_JSON=
```

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| 404 bei Box Shared Link | Sharing-Einstellungen prüfen → "People with the link" → "Can view" |
| Upload failed | Developer Token abgelaufen → Neuen Token generieren (max 60 Min) |
| Folder nicht gefunden | Folder ID prüfen: `box folders:children 0` |
| Rate Limit | Box Free = 10 GB + 10k API calls/day |

---

## Related
- [Infra-SIN-Docker-Empire](https://github.com/OpenSIN-AI/Infra-SIN-Docker-Empire) — Docker Infrastructure
- [OpenSIN-onboarding](https://github.com/OpenSIN-AI/OpenSIN-onboarding) — User Onboarding
- [OpenSIN-documentation](https://github.com/OpenSIN-AI/OpenSIN-documentation) — Documentation
