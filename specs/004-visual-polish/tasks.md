# Tasks: Visual Polish & Assets

**Input**: Design documents from `specs/004-visual-polish/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md

**Tests**: Not explicitly requested, so test tasks will not be generated.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: `src/`, `tests/` at repository root, as defined in `plan.md`.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare project structure for new components.

- [x] T001 Create `assets/backgrounds/` directory.
- [x] T002 Create `src/ui/floating_health_bar.tscn` placeholder scene.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: No specific blocking tasks for this feature.

---

## Phase 3: User Story 1 - Character Visuals (Priority: P1)

**Goal**: Player and Enemy characters use sprite assets.

**Independent Test**: The game runs, and Player/Enemy are visible with their new sprites.

### Implementation for User Story 1

- [x] T003 Update `src/characters/player.tscn` to add `Sprite2D` node, assign `human.tres`, and set initial scale.
- [x] T004 Update `src/characters/enemy.tscn` to add `Sprite2D` node, assign `orc.tres`, and set initial scale.

**Checkpoint**: Characters have proper visuals.

---

## Phase 4: User Story 2 - Combat Clarity (Priority: P1)

**Goal**: Clear visual feedback for targeting and enemy health.

**Independent Test**: Targeting an enemy shows a red circle behind it, and damaging an enemy updates its floating health bar.

### Implementation for User Story 2

- [x] T005 Update `src/ui/target_indicator.tscn` for red circle visual and lower Z-index (-1).
- [x] T006 Create `src/ui/floating_health_bar.gd` script.
- [x] T007 Update `src/ui/floating_health_bar.tscn` UI definition.
- [x] T008 Update `src/characters/enemy.tscn` to instance `FloatingHealthBar` and connect health signals.

**Checkpoint**: Combat feedback is visually clear.

---

## Phase 5: User Story 3 - Environmental Atmosphere (Priority: P2)

**Goal**: Arena has a background image.

**Independent Test**: The game starts, and a background image is visible.

### Implementation for User Story 3

- [x] T009 Update `src/core/arena.tscn` to add `TextureRect` for background.
- [x] T010 Assign background image resource to `TextureRect` (Prompt user for path).

**Checkpoint**: Arena has an atmospheric background.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final validation.

- [x] T011 Run `quickstart.md` validation.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup**: No dependencies.
- **US1 (Character Visuals)**: Depends on Setup (sprite assets).
- **US2 (Combat Clarity)**: Depends on US1 (character scenes).
- **US3 (Environmental Atmosphere)**: Can be done in parallel with US1/US2.

---

## Implementation Strategy

### MVP First (US1 + US2 + US3)

1.  Complete character visuals.
2.  Implement targeting and health bar feedback.
3.  Add background.
4.  **STOP and VALIDATE**: Playable with core visuals.

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Verify tests fail before implementing
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence
