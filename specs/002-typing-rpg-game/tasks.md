# Tasks: Typing RPG Game Core Mechanics

**Input**: Design documents from `specs/002-typing-rpg-game/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: Not explicitly requested, so test tasks will not be generated.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: `src/`, `tests/` at repository root, as defined in `plan.md`.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure.

- [x] T001 Initialize a new Godot 4.x project in the repository root (creating `project.godot`).
- [x] T002 [P] Create the project directory structure: `src/abilities`, `src/characters`, `src/core`, `src/ui`, `src/util`, `tests/abilities`, `tests/characters`, `tests/core`.
- [x] T003 Configure the GUT (Godot Unit Test) plugin via the Godot editor's AssetLib.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete.

- [x] T004 [P] Implement the base data model for `Ability` as a custom resource in `src/abilities/ability.gd` based on `data-model.md`.
- [x] T005 [P] Implement the base data model for `StatusEffect` as a custom resource in `src/core/status_effect.gd` based on `data-model.md`.
- [x] T006 Implement the `Character` base scene and script in `src/characters/character.tscn` and `src/characters/character.gd` based on `i_character.gd`.
- [x] T007 Implement the `Player` scene and script in `src/characters/player.tscn` and `src/characters/player.gd`, inheriting from Character.
- [x] T008 Implement the `Enemy` scene and script in `src/characters/enemy.tscn` and `src/characters/enemy.gd`, inheriting from Character.
- [x] T009 Implement the code-only State Machine in `src/core/state_machine.gd` based on `i_game_state_machine.gd`.
- [x] T010 Create the main Arena scene in `src/core/arena.tscn` with placeholder Player and Enemy instances.

**Checkpoint**: Foundation ready - user story implementation can now begin.

---

## Phase 3: User Story 1 - Cast a Damage Ability (Priority: P1) 🎯 MVP

**Goal**: Player can cast a damage-dealing ability by typing a sequence of characters to defeat an enemy.

**Independent Test**: The player can start the arena scene, successfully cast a damage ability by typing, and see the enemy's health decrease.

### Implementation for User Story 1

- [x] T011 [P] [US1] Create a concrete `DamageAbility` resource in `src/abilities/` that inherits from `ability.gd`.
- [x] T012 [P] [US1] Implement input handling logic in `src/core/input_handler.gd` to capture keyboard input.
- [x] T013 [US1] Integrate the `input_handler.gd` with the `player.gd` script to manage the `current_typing_input` state.
- [x] T014 [US1] Implement the ability casting logic in `player.gd` to trigger the `DamageAbility` when the typing pattern matches.
- [x] T015 [US1] Implement the `_take_damage` method in `character.gd` to reduce health.
- [x] T016 [P] [US1] Create a basic HUD scene in `src/ui/hud.tscn` for displaying player and enemy health bars.
- [x] T017 [US1] Integrate the `hud.tscn` into the `arena.tscn` and connect health signals from characters.

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently.

---

## Phase 4: User Story 2 - Apply a Buff or Debuff (Priority: P2)

**Goal**: Player can cast abilities that apply beneficial buffs to themselves or detrimental debuffs to enemies.

**Independent Test**: The player can cast a buff on themselves and see a status icon, or cast a debuff on an enemy and see a status icon and observe a negative effect.

### Implementation for User Story 2

- [x] T018 [P] [US2] Create a concrete `BuffAbility` resource in `src/abilities/` that creates and applies a `StatusEffect`.
- [x] T019 [P] [US2] Create a concrete `DebuffAbility` resource in `src/abilities/` that creates and applies a `StatusEffect`.
- [x] T020 [US2] Implement the logic in `character.gd` to apply, process (e.g., tick down duration), and remove `StatusEffect`s.
- [x] T021 [P] [US2] Create a UI component in `src/ui/` to display status effect icons.
- [x] T022 [US2] Update the `hud.tscn` to include the status effect display for the player and enemy.

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently.

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories.

- [ ] T023 Implement the ability cooldown display in `src/ui/hud.tscn`.
- [ ] T024 [P] Implement visual feedback for successful and failed ability casts (e.g., simple particle effects or text popups).
- [ ] T025 Implement the progressive difficulty system for typing patterns (e.g., by creating different `Ability` resources for different levels).
- [ ] T026 Run `quickstart.md` validation to ensure setup instructions are correct.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies.
- **Foundational (Phase 2)**: Depends on Setup completion. BLOCKS all user stories.
- **User Stories (Phase 3+)**: All depend on Foundational phase completion.
- **Polish (Phase 5)**: Depends on all desired user stories being complete.

### User Story Dependencies

- **User Story 1 (P1)**: Starts after Foundational (Phase 2).
- **User Story 2 (P2)**: Starts after Foundational (Phase 2). Can be developed in parallel with User Story 1.

### Parallel Opportunities

- Tasks marked with [P] can often be worked on in parallel within their phase.
- Once the Foundational phase is complete, different developers can work on User Story 1 and User Story 2 simultaneously.

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1.  Complete Phase 1: Setup
2.  Complete Phase 2: Foundational (CRITICAL)
3.  Complete Phase 3: User Story 1
4.  **STOP and VALIDATE**: Test User Story 1 independently.

### Incremental Delivery

1.  Complete Setup + Foundational.
2.  Add User Story 1 → Test independently.
3.  Add User Story 2 → Test independently.
