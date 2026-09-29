<img width="1917" height="1080" alt="desktop" src="https://github.com/user-attachments/assets/ae86182a-83f8-438f-bc12-e89fa7e19a1c" />

# .dotfiles

My personal Linux environment configuration.

This repository stores the parts of my system that I intentionally customize and want to reproduce.

Not a full home backup — only configurations that matter.

---

## Structure

```text
.dotfiles/
├── terminal/     # Shell, prompt, Konsole
├── DE/           # KDE Plasma configuration
├── apps/         # Application configs
├── system/       # System-level configs
├── scripts/      # Helper scripts
├── packages/     # Software lists
└── sync.sh       # Main sync script
````

---

## Sync

Each section manages itself with its own `sync.sh`.

Run:

```bash
./sync.sh
```

The script will:

* Run all enabled sync modules
* Create missing directories
* Skip unavailable modules
* Report sync status

After changes:

```bash
git add .
git commit -m "sync: update dotfiles"
git push
```

---

## Current Setup

### Desktop

* Fedora Linux
* KDE Plasma
* Sweet theme
* Kvantum styling

### Terminal

* Zsh
* Zinit
* Starship
* fzf
* zoxide
* KDE Konsole

### Applications

Managed:

* VS Code
* Firefox UI customization
* Rofi launcher

---

## Philosophy

I don't backup everything.

I keep only:

✅ intentional customization
✅ workflow improvements
✅ reproducible settings

Excluded:

* Cache
* Sessions
* Passwords
* Tokens
* Personal data

---

## Notes

This repository grows with my setup.

It is not just a backup — it is a record of building my Linux environment.

```

This feels much more like a real GitHub repo README.

Your detailed stuff is still valuable though. I would move it somewhere like:

```

docs/
├── terminal.md
├── kde.md
├── firefox.md
└── setup-notes.md

