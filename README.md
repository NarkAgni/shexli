<div align="center">

# shexli - CLI Setup Guide

> **shexli** is a static analyzer for GNOME Shell extensions. <br>
> It is developed and maintained by the **GNOME Infrastructure team** as part of the *extensions-web* project - the same system that powers the official GNOME Extensions website.

[![GitLab Project](https://img.shields.io/badge/extensions--web_Project-330F55?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.gnome.org/Infrastructure/extensions-web)
[![GNOME Extensions](https://img.shields.io/badge/GNOME_Extensions-4A86CF?style=for-the-badge&logo=gnome&logoColor=white)](https://extensions.gnome.org)

*All credit goes to the original authors and contributors of that project.<br>
This guide only makes it easier to run the `shexli` CLI locally. I have not written any of the code.*

</div>

---

## Requirements

- Python 3.12 or higher
- pip
- sudo access (for symlink creation)

---

## Installation

```bash
git clone https://github.com/narkagni/shexli.git
cd shexli
bash install.sh
```

## Usage

Analyze an extension directory

```bash
shexli /path/to/extension/
```

Analyze a zipped extension

```bash
shexli /path/to/extension.zip
```

## Output

### Text Output

```bash
shexli /path/to/extension/ --format/-f text

status: issues_found
findings: 4
[warning] EGO025 Compiled GSettings schemas should not be shipped for 45+ packages.
[warning] EGO033 Preferences code stores window-scoped objects on the exported prefs class without `close-request` cleanup.
[warning] EGO030 Shell code should avoid synchronous file IO APIs like `GLib.file_get_contents()` and `Gio.File.load_contents()`.
[warning] EGO016 Main loop sources assigned in `enable()` are missing matching removals in `disable()` or its helper methods.
```
### JSON Output
```
shexli /path/to/extension/ --format/-f json

{
  "spec_version": "2026-04-02",
  "summary": {
    "input_path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni",
    "finding_count": 4,
    "severity_counts": {
      "warning": 4
    },
    "status": "issues_found"
  },
  "findings": [
    {
      "rule_id": "EGO025",
      "title": "unnecessary build and translation artifacts should not be shipped",
      "severity": "warning",
      "message": "Compiled GSettings schemas should not be shipped for 45+ packages.",
      "evidence": [
        {
          "path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni/schemas/gschemas.compiled",
          "line": null,
          "snippet": "schemas/gschemas.compiled"
        }
      ],
      "source_url": "https://gjs.guide/extensions/review-guidelines/review-guidelines.html#don-t-include-unnecessary-files",
      "source_section": "Don't include unnecessary files"
    },
    {
      "rule_id": "EGO033",
      "title": "preferences classes should not retain window-scoped objects on instance fields without close-request cleanup",
      "severity": "warning",
      "message": "Preferences code stores window-scoped objects on the exported prefs class without `close-request` cleanup.",
      "evidence": [
        {
          "path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni/prefs.js",
          "line": 33,
          "snippet": "this.settings = this.getSettings()"
        }
      ],
      "source_url": "https://gjs.guide/extensions/review-guidelines/review-guidelines.html#destroy-all-objects",
      "source_section": "Destroy all objects"
    },
    {
      "rule_id": "EGO030",
      "title": "extensions should avoid synchronous file IO in shell code",
      "severity": "warning",
      "message": "Shell code should avoid synchronous file IO APIs like `GLib.file_get_contents()` and `Gio.File.load_contents()`.",
      "evidence": [
        {
          "path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni/src/browsers/EmojiBrowser.js",
          "line": 35,
          "snippet": "file.load_contents(null)"
        },
        {
          "path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni/src/services/ClipboardManager.js",
          "line": 67,
          "snippet": "this._clipboardFile.load_contents(null)"
        },
        {
          "path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni/src/services/PluginManager.js",
          "line": 49,
          "snippet": "file.load_contents(null)"
        },
        {
          "path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni/src/services/SnippetManager.js",
          "line": 71,
          "snippet": "this._file.load_contents(null)"
        }
      ],
      "source_url": "https://gjs.guide/guides/gio/file-operations.html",
      "source_section": "File Operations"
    },
    {
      "rule_id": "EGO016",
      "title": "main loop sources should be removed in disable()",
      "severity": "warning",
      "message": "Main loop sources assigned in `enable()` are missing matching removals in `disable()` or its helper methods.",
      "evidence": [
        {
          "path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni/src/services/SnippetManager.js",
          "line": 46,
          "snippet": "                    GLib.idle_add(GLib.PRIORITY_DEFAULT_IDLE, () => {\n                        this._load();\n                        return GLib.SOURCE_REMOVE;\n                    })"
        }
      ],
      "source_url": "https://gjs.guide/extensions/review-guidelines/review-guidelines.html#remove-main-loop-sources",
      "source_section": "Remove main loop sources"
    }
  ],
  "artifacts": {
    "root": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni",
    "metadata_path": "/home/narkagni/.local/share/gnome-shell/extensions/rudrabeta@narkagni/metadata.json",
    "js_file_count": 27,
    "file_count": 34,
    "limits": {
      "max_files": 5000,
      "max_file_size_bytes": 10485760,
      "max_total_file_bytes": 52428800,
      "max_zip_members": 5000,
      "max_zip_uncompressed_bytes": 52428800,
      "max_zip_compression_ratio": 1000
    },
    "target_versions": [
      45,
      46,
      47,
      48,
      49,
      50
    ]
  }
}
```

## Source

Original project: https://gitlab.gnome.org/Infrastructure/extensions-web

All code belongs to the GNOME Infrastructure team and contributors
<br>
License: AGPL-3.0-or-later