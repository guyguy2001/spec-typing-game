# Phase 0: Research

## Unknowns

1. **RichTextLabel Styling Performance**: How to efficiently update Godot 4.x `RichTextLabel` with BBCode for typing feedback? Is it performant to update `text` property every frame/keystroke?
2. **Input Handling**: The current `InputHandler` emits `text_input`. We need to accumulate this into a buffer. Where should this buffer live? `Arena`? `Player`? Or a new `InputManager`?
    - The user suggested: "There should be a component along the lines of 'typable-text'... It should listen to a signal specifying that the currently written text has changed... There should be a node that reads the input from the player, and fires that event."
3. **UI Hierarchy**: Where to place the new "Input Bar"? In `HUD`?

## Research Tasks

1. **Task: Verify RichTextLabel BBCode capabilities.**
    - Confirm `RichTextLabel` supports the required color tags (`[color=red]...[/color]`).
    - Confirm `RichTextLabel` can handle frequent updates (every keystroke).

2. **Task: Define "TypableText" Component.**
    - This seems to be a UI component that wraps a `RichTextLabel` and listens to `input_buffer_changed(new_text)`.
    - It needs to match its internal `target_text` against `new_text`.

3. **Task: Define "Input Reader" Node.**
    - `InputHandler` already captures raw input.
    - We need an `InputBuffer` node (maybe part of `Player` or `Arena`) that:
        - Listens to `InputHandler.text_input` and `backspace_pressed`.
        - Maintains a `current_string`.
        - Emits `input_buffer_changed(current_string)`.
        - Clears on "commit" (successful cast) or "reset" (timeout/interrupt).

## Findings

### 1. RichTextLabel
Godot 4.x `RichTextLabel` is robust. Updating `text` property with new BBCode string on every keystroke is standard practice for typing games and is performant enough for UI text.
BBCode: `[color=#FF0000]matched[/color][color=#FFFFFF]remaining[/color]`.

### 2. Architecture Decisions
- **Input Source**: Reuse `src/core/input_handler.gd`.
- **Input Buffer**: Create a new class `InputBuffer` (Node) in `src/core/`.
    - Responsibilities: Subscribe to `InputHandler`, manage string state, emit change signal.
- **Typable Text**: Create `src/ui/typable_label.gd` (extends `RichTextLabel`).
    - Responsibilities: Export `target_text`, subscribe to `InputBuffer.text_changed`, update own BBCode.
- **Input Bar**: Create `src/ui/input_feedback_bar.gd` (extends `Control` -> `Label` or `RichTextLabel`).
    - Responsibilities: Subscribe to `InputBuffer.text_changed`, display current buffer.

### 3. Integration
- `Arena` will instantiate `InputHandler` (already does).
- `Arena` (or `Player`) will instantiate `InputBuffer`.
- `HUD` will contain `InputFeedbackBar`.
- `AbilityIcon` will replace its standard `Label` with `TypableLabel`.

## Rationale
- Decoupling `InputBuffer` from `Player` allows for other things to drive input (e.g., automated tests, cutscenes) or multiple players.
- `TypableLabel` as a standalone component allows any text in the game (dialogue, menus) to become "typable" easily.
- Using Godot's built-in Signals is the standard way to decouple these systems.
