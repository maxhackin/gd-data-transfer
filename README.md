# GD Data Transfer

Move **Geometry Dash 2.2081** saves, levels, songs, Geode mods, and macros from one Windows PC to another.

Geometry Dash does **not** keep your account or editor levels in the game folder. Those files live in:

```
%LOCALAPPDATA%\GeometryDash
  CCGameManager.dat     progress, icons, stats, account
  CCLocalLevels.dat     created / saved levels
```

This app packs that AppData data (plus mods/macros from your `2.2081` folder) and imports it into the other PC's Geometry Dash.

This GitHub repo is **the tool only**. Your actual save files stay on your computer. Copy the exported pack with USB / OneDrive separately.

---

## On the other PC (download and launch)

1. Open **https://github.com/maxhackin/gd-data-transfer**
2. Click **Code** → **Download ZIP**
3. Extract the zip (Windows: right-click → Extract All)
4. Close Geometry Dash
5. Double-click **`Launch GD Data Transfer.bat`**
6. Choose **Import pack** and point it at your `_gd_transfer_pack` folder  
   (or, if the pack is already sitting next to `GeometryDash.exe`, double-click **`Import-GD-Data.bat` inside the pack** — that importer does not need Python)

Python is only needed for the windowed app. Install it from https://www.python.org/downloads/ and tick **Add python.exe to PATH**.

---

## On this PC (export your data)

1. Close Geometry Dash
2. Double-click **`Launch GD Data Transfer.bat`**
3. Leave **Export pack** selected
4. Destination defaults to your game folder:

   `...\2.2081\_gd_transfer_pack`

   That way OneDrive / a USB copy of `2.2081` carries the pack with the game. You can Browse to a USB stick instead.
5. Tick what you want (songs are large, ~2 GB; renders are optional)
6. Click **Start transfer** and wait

Then take `_gd_transfer_pack` (or the whole `2.2081` folder) to the other PC.

---

## What can be copied

| Category | Where it lives |
| --- | --- |
| Account & progress | `CCGameManager.dat` |
| Created / saved levels | `CCLocalLevels.dat` |
| Music library | `musiclibrary.dat` |
| Custom songs & SFX | AppData `.mp3` / `.ogg` |
| Geode mod settings | `%LOCALAPPDATA%\\GeometryDash\\geode` |
| Editor backups & trash | BetterEdit / trashcan |
| Geode mods + config | `2.2081\\geode` |
| Macros | `2.2081\\macros` |
| Astral macros | `2.2081\\Astral` |
| Replays / autosaves | `2.2081\\replays`, `autosaves` |
| Renders | `2.2081\\renders` (off by default) |
| Extra `.bak` copies | old level backups (off by default) |

---

## Safety

- Geometry Dash must be **closed** on both PCs
- Import backs up the other PC's existing `.dat` files to  
  `%LOCALAPPDATA%\\GeometryDash\\_import_backup_TIMESTAMP`  
  before overwriting
- Import **replaces** save files. It does not merge two accounts

---

## Troubleshooting

**Geometry Dash is open**  
End `GeometryDash.exe` in Task Manager, then retry.

**Icons / stars missing**  
You imported levels but not Account & progress, or GD was still open.

**Levels missing**  
You imported account but not Created / saved levels.

**Mods missing**  
Point the game folder at the 2.2081 install that has `Geode.dll`.

**Songs silent**  
Tick Custom songs & SFX. They are not in the game folder.

**Python not found**  
You only need Python for the window. A finished pack's `Import-GD-Data.bat` uses PowerShell and works without Python.
