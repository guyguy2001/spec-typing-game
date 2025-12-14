# Tasks: Visual Typing Feedback

**Feature**: Visual Typing Feedback and Input Bar
**Branch**: `005-please-make-text`
**Status**: Pending

## Phase 1: Setup

- [x] T001 Create feature directory structure for tests (if needed)

## Phase 2: Foundational (Blocking)

**Goal**: Implement the core `InputBuffer` to manage typing state centrally.

- [x] T002 Create `InputBuffer` script with signal definitions in `src/core/input_buffer.gd`
- [x] T003 Implement `InputBuffer` logic (`_on_text_input`, `_on_backspace`, `clear`) in `src/core/input_buffer.gd`
- [x] T004 Create `InputBuffer` unit test to verify signal emission and state management in `tests/unit/test_input_buffer.gd`
- [x] T005 Integrate `InputBuffer` into `Arena` scene and connect to `InputHandler` in `src/core/arena.gd`

## Phase 3: User Story 1 - Typist Input Visualization (P1)

**Goal**: Players see what they are typing in real-time.
**Independent Test**: Type characters in game, see them appear in the Input Bar.

- [x] T006 [US1] Create `InputFeedbackBar` scene and script in `src/ui/input_feedback_bar.tscn` and `src/ui/input_feedback_bar.gd`
- [x] T007 [US1] Implement `_on_input_changed` in `InputFeedbackBar` to update text in `src/ui/input_feedback_bar.gd`
- [x] T008 [US1] Add `InputFeedbackBar` to `HUD` scene and connect to `InputBuffer` signals in `src/ui/hud.tscn` and `src/ui/hud.gd`
- [x] T009 [P] [US1] Create integration test for Input Bar updating on typing in `tests/integration/test_input_bar_feedback.gd`

## Phase 4: User Story 2 - Target Text Progress Feedback (P2)

**Goal**: Ability names highlight correctly based on typed prefix.
**Independent Test**: Type partial ability name, see prefix turn red. Type wrong char, see reset.

- [x] T010 [US2] Create `TypableLabel` script extending `RichTextLabel` in `src/ui/typable_label.gd`
- [x] T011 [US2] Implement matching logic (prefix check) and BBCode updating in `src/ui/typable_label.gd`
- [x] T012 [P] [US2] Create unit test for `TypableLabel` matching logic (correct vs incorrect prefix) in `tests/unit/test_typable_label.gd`
- [x] T013 [US2] Create `TypableLabel` scene for reuse (optional, if prefabs needed) in `src/ui/typable_label.tscn`
- [x] T014 [US2] Replace standard Label with `TypableLabel` in `AbilityIcon` scene in `src/ui/ability_icon.tscn`
- [x] T015 [US2] Update `AbilityIcon` script to expose `target_text` to `TypableLabel` and connect signals in `src/ui/ability_icon.gd`
- [x] T016 [US2] Update `HUD` or `AbilityBar` to pass `InputBuffer` reference to `AbilityIcon`s in `src/ui/hud.gd` or `src/ui/ability_bar.gd`

## Phase 5: Polish & Cross-Cutting

- [x] T017 Verify edge case: Empty input clears all highlighting
- [x] T018 Verify edge case: Incorrect input resets highlighting (Red/White logic)
- [x] T019 Ensure no focus stealing occurs (check `InputFeedbackBar` mouse filter/focus mode)

## Dependencies

1. **Foundational** (T002-T005) MUST be done first. `InputBuffer` is the data source.
2. **US1** (Input Bar) and **US2** (Typable Label) can be done in parallel after Foundational.
3. **US2 Integration** (T016) depends on **US2 Components** (T010-T015).

## Parallel Execution Examples

- **Developer A**: Work on **US1** (T006-T009) - Visualizing the raw input.
- **Developer B**: Work on **US2** (T010-T013) - The matching logic and `TypableLabel` component.

## Implementation Strategy

1. **MVP**: Implement `InputBuffer` + `InputFeedbackBar`. This proves the input loop works.
2. **Core Gameplay**: Implement `TypableLabel`. This enables the actual game mechanic visualization.
3. **Integration**: Hook it all up in the `HUD` and `Arena`.
