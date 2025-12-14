# spec-typing-game Development Guidelines

Auto-generated from all feature plans. Last updated: 2025-12-12

## Active Technologies

- GDScript (Godot 4.x) + Existing custom State Machine. (003-minimal-combat-loop)
- N/A (Session-based). (003-minimal-combat-loop)

- GDScript (Godot 4.x) + Custom code for State Machine (no external extensions). (002-typing-rpg-game)

## Project Structure

```text
src/
tests/
```

## Primary Workflows

### Post Task Validations

After completing a task, before moving to the next one, and before committing, run the tests in the repo to make sure the code works correctly.
The command for that is `& "C:\Users\User\.local\bin\Godot_v4.5.1-stable_win64_console.exe" --headless -s addons/gut/gut_cmdln.gd -gdir tests/unit -gexit -gtest <test-files>`

## Commands

## Code Style

GDScript (Godot 4.x): Follow specs\godot_conventions.md, or standard conventions if the file doesn't specify.
tscn files: Adhere to the notes in specs/tscn_format_notes.md and the format specification in specs/tscn_file_format.rst when creating/editing scene files.

## Recent Changes

- 004-visual-polish: Added GDScript (Godot 4.x) + Existing custom State Machine.
- 003-minimal-combat-loop: Added GDScript (Godot 4.x) + Existing custom State Machine.

- 002-typing-rpg-game: Added GDScript (Godot 4.x) + Custom code for State Machine (no external extensions).

<!-- MANUAL ADDITIONS START -->
<!-- MANUAL ADDITIONS END -->
