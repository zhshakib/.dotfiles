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
├── sync.sh         # Sync live configuration into this repo
└── README.md
```

The structure will grow as the setup grows.

I don't want to create folders just for the sake of having folders.

---

## Terminal

The `terminal/` directory contains the things that make my terminal behave the way I want.

Currently:

```text
terminal/
├── .zshrc
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

---

## Desktop Environment

`DE/` contains configuration related to the desktop environment.

For now, this is mainly focused on KDE Plasma.

```text
DE/
└── kde/
```

Only configurations that represent intentional desktop customizations should go here.

I don't want to blindly back up the entire `~/.config` directory.

---

## Applications

Application-specific configuration will live under `apps/`.

Examples might eve
