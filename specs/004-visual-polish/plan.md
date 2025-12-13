# Implementation Plan: Visual Polish & Assets

**Branch**: `004-visual-polish` | **Date**: 2025-12-12 | **Spec**: ../spec.md
**Input**: Feature specification from `/specs/004-visual-polish/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Implement visual upgrades including sprite integration for characters, an updated red circle target indicator behind enemies, floating health bars for enemies, and a background image for the arena.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: GDScript (Godot 4.x)
**Primary Dependencies**: Existing custom State Machine.
**Storage**: N/A.
**Testing**: GUT (Godot Unit Test).
**Target Platform**: Desktop (Windows, macOS, Linux).
**Project Type**: Single project.
**Performance Goals**: Maintain 60 fps.
**Constraints**: Type-hinted GDScript.
**Scale/Scope**: enhancing visual presentation of existing systems.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

[Gates determined based on constitution file]

## Project Structure

### Documentation (this feature)

```text
specs/004-visual-polish/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
src/
├── characters/    # Updated Player.tscn, Enemy.tscn
├── core/          # Updated Arena.tscn
├── ui/            # FloatingHealthBar.tscn, TargetIndicator.tscn (update)
└── util/

assets/
├── sprites/       # Player/Enemy sprites
└── backgrounds/   # Background image
```

**Structure Decision**: Extending existing structure. New `assets/backgrounds` directory. New `FloatingHealthBar` UI component.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
