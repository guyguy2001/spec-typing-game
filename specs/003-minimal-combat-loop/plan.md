# Implementation Plan: Minimal Combat Loop

**Branch**: `003-minimal-combat-loop` | **Date**: 2025-12-12 | **Spec**: ../spec.md
**Input**: Feature specification from `/specs/003-minimal-combat-loop/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Implementation of a minimal combat loop including enemy AI attacks, respawning logic, game over state, and tab-based targeting for multiple enemies.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: GDScript (Godot 4.x)
**Primary Dependencies**: Existing custom State Machine.
**Storage**: N/A (Session-based).
**Testing**: GUT (Godot Unit Test).
**Target Platform**: Desktop (Windows, macOS, Linux).
**Project Type**: Single project.
**Performance Goals**: Maintain 60 fps with multiple enemies.
**Constraints**: Type-hinted GDScript.
**Scale/Scope**: Extensions to existing Arena and Character systems to support combat loop and multiple enemies.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

[Gates determined based on constitution file]

## Project Structure

### Documentation (this feature)

```text
specs/003-minimal-combat-loop/
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
├── abilities/     # Ability resources
├── characters/    # EnemyAIController.gd
├── core/          # Arena.gd updates, GameStateMachine
├── ui/            # GameOver.tscn
└── util/

tests/
```

**Structure Decision**: Extending the existing single-project structure. New AI logic goes in `characters/` or `core/`. Game Over UI goes in `ui/`.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
