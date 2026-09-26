<img width="1917" height="1080" alt="image" src="https://github.com/user-attachments/assets/ae86182a-83f8-438f-bc12-e89fa7e19a1c" />

# .dotfiles

My personal Linux environment, configuration, and setup files.

This repository is a record of how I configure my machine — from the terminal and shell to KDE, applications, tools, and other system-level preferences.

The goal isn't to copy every file from my home directory.

The goal is to keep the configuration that I **intentionally customized and actually care about reproducing**.

---

## Structure

```text
.dotfiles/
├── terminal/       # Shell, prompt, terminal emulator
├── DE/             # Desktop environment configuration
├── apps/           # Application-specific configuration
├── system/         # System-level configuration and setup
├── scripts/        # Personal helper and automation scripts
├── packages/       # Package/software lists
├── sync.sh         # Orchestrator — runs every sub-sync
└── README.md
```

The structure will grow as the setup grows.

I don't want to create folders just for the sake of having folders.

---

## Syncing

Each folder owns its own `sync.sh`. The root `sync.sh` just triggers them all.

```bash
./sync.sh
```

It will:

- Ensure every `sync.sh` in the repo is executable (no manual `chmod`)
- Run each folder's `sync.sh` in order
- Print a `[folder]` prefix on every line so you know who's talking
- Skip folders that don't have a `sync.sh` yet
- Exit non-zero if any sub-sync fails

Output looks like:

```
🔄 Syncing dotfiles → /home/<user>/.dotfiles

▶ DE
→ [DE] config: kdeglobals
...
✅ [DE] sync complete

▶ terminal
→ [terminal] zshrc
...
✅ [terminal] sync complete

✅ all syncs complete
```

Then review and commit:

```bash
git add .
git diff --cached --stat
git commit -m "sync: update dotfiles"
git push
```

### Adding a new folder

1. Create `<folder>/sync.sh` following the same pattern
2. Uncomment the folder name in the `SUBSYNC_DIRS` array in root `sync.sh`
3. Done — no orchestrator logic to rewrite

---

## Terminal

The `terminal/` directory contains the things that make my terminal behave the way I want.

```text
terminal/
├── sync.sh
├── zshrc
├── starship.toml
└── Starship.colorscheme
```

Current setup includes:

* Zsh
* Zinit
* zsh-autosuggestions
* zsh-syntax-highlighting
* fzf
* zoxide
* Starship
* KDE Konsole

`sync.sh` pulls:

| Source | Repo path |
|---|---|
| `~/.zshrc` | `terminal/zshrc` |
| `~/.config/starship.toml` | `terminal/starship.toml` |
| `~/.local/share/konsole/Starship.colorscheme` | `terminal/Starship.colorscheme` |

---

## Desktop Environment

`DE/` contains configuration related to the desktop environment.

Currently focused on KDE Plasma.

```text
DE/
├── sync.sh
├── config/         # ~/.config/* — selected files only
└── konsole/        # ~/.local/share/konsole/*
```

Only configurations that represent intentional desktop customizations go here.

I don't want to blindly back up the entire `~/.config` directory.

`sync.sh` pulls:

**Core config:**
- `kdeglobals` — theme, colors, fonts
- `plasmarc` — Plasma shell theme
- `plasmashellrc` — shell-level settings
- `kwinrc` — window manager (effects, tiling)
- `kglobalshortcutsrc` — keyboard shortcuts
- `khotkeysrc` — custom hotkeys
- `konsolerc` — Konsole main config
- `plasma-org.kde.plasma.desktop-appletsrc` — full desktop layout (panels, widgets, positions)
- `plasmanotifyrc` — notification settings
- `powermanagementprofilesrc` — power profiles

**Konsole assets:**
- All files in `~/.local/share/konsole/`

> Note: `plasma-org.kde.plasma.desktop-appletsrc` changes every time you move a widget.
> Commit it when the layout is in a state you want to keep — not after every micro-tweak.

---

## Applications

Application-specific configuration will live under `apps/`.

Examples might eventually include: VS Code, Git, Alacritty, tmux, SSH, etc.

*Not populated yet.*

---

## System

System-level configuration will live under `system/`.

Examples might eventually include: `/etc/` tweaks, systemd units, firewall rules, DNF configs.

*Not populated yet.*

---

## Scripts

Personal helper and automation scripts will live under `scripts/`.

*Not populated yet.*

---

## Packages

Package lists and software manifests will live under `packages/`.

Likely format: `dnf list installed`, Flatpak lists, RPM Fusion/COPR enables.

*Not populated yet.*

---

## What's NOT included (on purpose)

- Caches (`~/.cache`)
- Session state (`~/.local/state`)
- Browser profiles, wallets, tokens
- Anything containing secrets
- `~/.config` wholesale — only what I intentionally customized

---

## Safety notes

- **Never run `sync.sh` as `sudo`.** It reads from `$HOME` only.
- **Before committing**, scan for secrets:
  ```bash
  grep -riE "token|password|secret|api_key" . --exclude-dir=.git
  ```
