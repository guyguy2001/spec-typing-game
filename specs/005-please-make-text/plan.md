# Implementation Plan: Visual Typing Feedback

**Branch**: `005-please-make-text` | **Date**: 2025-12-14 | **Spec**: [specs/005-please-make-text/spec.md](../spec.md)
**Input**: Feature specification from `/specs/005-please-make-text/spec.md`

## Summary

Implement a visual feedback system for typing that includes a dedicated "Input Bar" showing the player's current keystrokes and "Typable Labels" that color-code matching prefixes on ability text. This involves decoupling input accumulation into an `InputBuffer` node and creating reactive UI components that subscribe to input changes.

## Technical Context

**Language/Version**: GDScript (Godot 4.x)
**Primary Dependencies**: Godot Control Nodes (RichTextLabel, Label)
**Storage**: N/A (Transient UI state)
**Testing**: GUT (Godot Unit Test)
**Target Platform**: Desktop (Windows/Linux/Mac)
**Project Type**: Single Godot Project
**Performance Goals**: Update UI on every keystroke (<16ms frame time).
**Constraints**: No focus stealing (cannot use LineEdit).

## Constitution Check

*GATE: Passed.*
- **Code Quality**: Uses modular components (`InputBuffer`, `TypableLabel`) adhering to separation of concerns.
- **Testing**: Components are testable via GUT by simulating signals.
- **Design**: Decoupled architecture using Signals allows easy refactoring.
- **Performance**: RichTextLabel BBCode updates are performant for this scale.

## Project Structure

### Documentation (this feature)

```text
specs/005-please-make-text/
├── plan.md              # This file
├── research.md          # Design decisions
├── data-model.md        # Signal contracts and Entity definitions
└── quickstart.md        # Usage guide
```

### Source Code (repository root)

```text
src/
├── core/
│   ├── input_buffer.gd        # NEW: Manages typed string state
├── ui/
│   ├── typable_label.gd       # NEW: RichTextLabel with matching logic
│   ├── typable_label.tscn     # NEW: Scene for easy reuse
│   ├── input_feedback_bar.gd  # NEW: Displays current input
│   ├── input_feedback_bar.tscn# NEW: Scene for HUD integration
```

**Structure Decision**: Option 1 (Single Project). Extending existing `src/core` and `src/ui` directories.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None      | N/A        | N/A                                 |