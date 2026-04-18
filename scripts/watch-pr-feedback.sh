#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
python3 - "$ROOT" <<'PY'
import json
import sys
from pathlib import Path

root = Path(sys.argv[1])
manifest = json.loads((root / "required-files.manifest.json").read_text())
missing = [rel for rel in manifest["requiredFiles"] if not (root / rel).exists()]
if missing:
    print(json.dumps({"status": "failed", "missing": missing}, indent=2))
    raise SystemExit(1)
print(json.dumps({"status": "ok", "repo": "OpenSIN-AI/Infra-SIN-Dev-Setup"}, indent=2))
PY
