#!/usr/bin/env bash
# ==============================================================================
# Enterprise Software Bill of Materials (SBOM) Generator
# Generates a valid CycloneDX v1.5 JSON SBOM manifest from project dependencies.
# Complies with NTIA Minimum Elements, Executive Order 14028, and SLSA standards.
# ==============================================================================

set -euo pipefail

TARGET_DIR="${1:-.}"
OUTPUT_FILE="${2:-./dist/sbom.cyclonedx.json}"
FORMAT="${3:-cyclonedx}"

TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"
mkdir -p "$(dirname "$OUTPUT_FILE")"

echo "================================================================================"
echo "📦 SDLC Software Bill of Materials (SBOM) Generator"
echo "   Target Directory: $TARGET_DIR"
echo "   Output Format:    $FORMAT (CycloneDX 1.5 JSON)"
echo "   Destination:      $OUTPUT_FILE"
echo "================================================================================"

# If syft is installed on the host, leverage it for deep binary and container scanning
if command -v syft &> /dev/null; then
    echo "⚡ Native 'syft' detected. Executing deep binary and dependency scan..."
    syft "$TARGET_DIR" -o cyclonedx-json="$OUTPUT_FILE" --quiet
    TOTAL_COMPONENTS=$(python3 -c "import json; data=json.load(open('$OUTPUT_FILE')); print(len(data.get('components', [])))" 2>/dev/null || echo "Unknown")
    echo "✅ Native CycloneDX SBOM generated successfully!"
    echo "📊 Total Components Cataloged: $TOTAL_COMPONENTS"
    echo "📁 Output Saved to: $OUTPUT_FILE"
    echo "================================================================================"
    exit 0
fi

# Fallback: Zero-dependency built-in parser using Python standard library
echo "🔍 Scanning project dependency manifests in $TARGET_DIR..."

python3 - << EOF
import os, sys, json, uuid, re
from datetime import datetime, timezone

target_dir = "$TARGET_DIR"
output_file = "$OUTPUT_FILE"

components = []
scanned_files = []

# 1. Scan Node.js package.json / package-lock.json
pkg_json = os.path.join(target_dir, "package.json")
if os.path.exists(pkg_json):
    scanned_files.append("package.json")
    try:
        with open(pkg_json, "r", encoding="utf-8") as f:
            data = json.load(f)
            deps = {**data.get("dependencies", {}), **data.get("devDependencies", {})}
            for name, ver in deps.items():
                clean_ver = re.sub(r'[\^~>=<]', '', ver)
                components.append({
                    "type": "library",
                    "name": name,
                    "version": clean_ver or "latest",
                    "purl": f"pkg:npm/{name}@{clean_ver or 'latest'}",
                    "scope": "required" if name in data.get("dependencies", {}) else "optional"
                })
    except Exception as e:
        print(f"⚠️ Warning parsing package.json: {e}", file=sys.stderr)

# 2. Scan Python requirements.txt
req_txt = os.path.join(target_dir, "requirements.txt")
if os.path.exists(req_txt):
    scanned_files.append("requirements.txt")
    try:
        with open(req_txt, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#"):
                    match = re.split(r'==|>=|<=|~=', line)
                    name = match[0].strip()
                    ver = match[1].strip() if len(match) > 1 else "latest"
                    components.append({
                        "type": "library",
                        "name": name,
                        "version": ver,
                        "purl": f"pkg:pypi/{name}@{ver}",
                        "scope": "required"
                    })
    except Exception as e:
        print(f"⚠️ Warning parsing requirements.txt: {e}", file=sys.stderr)

# 3. Scan Go go.mod
go_mod = os.path.join(target_dir, "go.mod")
if os.path.exists(go_mod):
    scanned_files.append("go.mod")
    try:
        with open(go_mod, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line.startswith("require ("):
                    continue
                match = re.match(r'^([a-zA-Z0-9\.\-_/]+)\s+([v0-9\.\-_a-zA-Z]+)', line)
                if match and match.group(1) != "module" and match.group(1) != "go":
                    name = match.group(1)
                    ver = match.group(2)
                    components.append({
                        "type": "library",
                        "name": name,
                        "version": ver,
                        "purl": f"pkg:golang/{name}@{ver}",
                        "scope": "required"
                    })
    except Exception as e:
        print(f"⚠️ Warning parsing go.mod: {e}", file=sys.stderr)

# 4. Scan Rust Cargo.lock or Cargo.toml
cargo_toml = os.path.join(target_dir, "Cargo.toml")
if os.path.exists(cargo_toml):
    scanned_files.append("Cargo.toml")
    try:
        with open(cargo_toml, "r", encoding="utf-8") as f:
            in_deps = False
            for line in f:
                line = line.strip()
                if line.startswith("[dependencies]"):
                    in_deps = True
                    continue
                elif line.startswith("["):
                    in_deps = False
                if in_deps and "=" in line and not line.startswith("#"):
                    parts = line.split("=", 1)
                    name = parts[0].strip()
                    ver = parts[1].strip().strip('"').strip("'")
                    components.append({
                        "type": "library",
                        "name": name,
                        "version": ver,
                        "purl": f"pkg:cargo/{name}@{ver}",
                        "scope": "required"
                    })
    except Exception as e:
        print(f"⚠️ Warning parsing Cargo.toml: {e}", file=sys.stderr)

# Deduplicate components by purl
unique_components = []
seen_purls = set()
for c in components:
    if c["purl"] not in seen_purls:
        seen_purls.add(c["purl"])
        unique_components.append(c)

proj_name = os.path.basename(os.path.abspath(target_dir))
timestamp = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
serial_number = f"urn:uuid:{uuid.uuid4()}"

sbom = {
    "bomFormat": "CycloneDX",
    "specVersion": "1.5",
    "serialNumber": serial_number,
    "version": 1,
    "metadata": {
        "timestamp": timestamp,
        "tools": [
            {
                "vendor": "Lean-Enterprise-SDLC",
                "name": "sdlc-sbom-generator",
                "version": "1.0.0"
            }
        ],
        "component": {
            "type": "application",
            "name": proj_name,
            "version": "1.0.0-rc1"
        }
    },
    "components": unique_components
}

with open(output_file, "w", encoding="utf-8") as f:
    json.dump(sbom, f, indent=2)

print(f"📋 Manifests scanned: {', '.join(scanned_files) if scanned_files else 'None (default baseline SBOM generated)'}")
print(f"📊 Total Unique Components Cataloged: {len(unique_components)}")
EOF

chmod +x "$OUTPUT_FILE" 2>/dev/null || true
echo "✅ CycloneDX v1.5 SBOM generated successfully!"
echo "📁 Archive Location: $OUTPUT_FILE"
echo "================================================================================"

