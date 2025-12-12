# Tasks: Minimal Combat Loop

**Input**: Design documents from `specs/003-minimal-combat-loop/`
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

- [x] T001 Create `src/ai/` directory for AI scripts.
- [x] T002 Create `src/ui/game_over.tscn` placeholder scene.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure updates required for the combat loop.

- [x] T003 Refactor `src/core/arena.gd` to support dynamic enemy spawning (add `spawn_enemy` function, remove hardcoded `@onready var enemy`).
- [x] T004 [P] Create `src/ai/enemy_ai_controller.gd` script skeleton.

**Checkpoint**: Core systems ready for logic implementation.

---

## Phase 3: User Story 1 - Enemy Fights Back (Priority: P1)

**Goal**: Enemy periodically attacks the player.

**Independent Test**: Run the game; the player takes damage periodically from the enemy.

### Implementation for User Story 1

- [x] T005 [US1] Implement `EnemyAIController` logic in `src/ai/enemy_ai_controller.gd` (Timer + Attack logic).
- [x] T006 [US1] Create a concrete `EnemyAttackAbility` resource in `src/abilities/enemy_attack.gd` (or reuse DamageAbility with specific values).
- [x] T007 [US1] Attach `EnemyAIController` node/script to `src/characters/enemy.tscn` and assign the attack ability.
- [ ] T008 [US1] Ensure `EnemyAIController` calls `ability._cast` on the Player target.

**Checkpoint**: The enemy is now dangerous.

---

## Phase 4: User Story 2 - Continuous Combat (Priority: P1)

**Goal**: Enemies respawn after death, creating an infinite loop.

**Independent Test**: Kill an enemy; a new one spawns shortly after.

### Implementation for User Story 2

- [ ] T009 [US2] Update `src/core/arena.gd` to listen for the `died` signal from spawned enemies.
- [ ] T010 [US2] Implement `_on_enemy_died` logic in `src/core/arena.gd` (queue_free old enemy, start timer, spawn new enemy).
- [ ] T011 [US2] Update `src/core/arena.tscn` to remove the hardcoded Enemy node (it will be spawned by script).

**Checkpoint**: The game is now an endless loop.

---

## Phase 5: User Story 3 - Game Over State (Priority: P1)

**Goal**: Player death triggers a Game Over screen with restart option.

**Independent Test**: Let the player die; verify Game Over screen appears and Restart works.

### Implementation for User Story 3

- [ ] T012 [P] [US3] Implement `src/ui/game_over.tscn` UI (Label "Game Over", Button "Restart").
- [ ] T013 [P] [US3] Create `src/ui/game_over.gd` to handle the Restart button (reload scene).
- [ ] T014 [US3] Update `src/core/arena.gd` to listen for `Player.died`.
- [ ] T015 [US3] Implement `_on_player_died` in `src/core/arena.gd` to instantiate/show `GameOver` scene and pause the game (or stop input).

**Checkpoint**: The game has a win (survival) and loss state.

---

## Phase 6: User Story 4 - Multi-Enemy Targeting (Priority: P2)

**Goal**: Support multiple enemies and Tab targeting.

**Independent Test**: Spawn 2 enemies; press Tab to switch target indicator between them.

### Implementation for User Story 4

- [ ] T016 [P] [US4] Create `src/ui/target_indicator.tscn` (e.g., a simple Sprite or ColorRect arrow).
- [ ] T017 [US4] Update `src/core/input_handler.gd` to capture `KEY_TAB` and emit `tab_pressed`.
- [ ] T018 [US4] Update `src/core/arena.gd` to spawn multiple enemies at start (e.g., 2).
- [ ] T019 [US4] Implement targeting logic in `src/core/arena.gd` (or Player):
    - Maintain list of enemies.
    - On `tab_pressed`, cycle `player.target_enemy` to next in list.
    - Move `TargetIndicator` to new target.

**Checkpoint**: Advanced combat mechanics are functional.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements and validation.

- [ ] T020 Run `quickstart.md` validation.
- [ ] T021 [P] Ensure floating text works for Enemy attacks too.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup & Foundational**: Must be done first.
- **US1 (Enemy Attack)**: Can be done after Foundational.
- **US2 (Respawn)**: Depends on US1 (need an enemy to kill/spawn).
- **US3 (Game Over)**: Depends on US1 (need damage to die). Can be parallel with US2.
- **US4 (Targeting)**: Depends on US2 (spawning logic).

---

## Implementation Strategy

### MVP First (US1 + US2 + US3)

1.  Get the enemy fighting back (US1).
2.  Make them respawn (US2).
3.  Handle player death (US3).
4.  **STOP and VALIDATE**: Playable loop.

### Advanced (US4)

1.  Add multi-enemy support and targeting.
