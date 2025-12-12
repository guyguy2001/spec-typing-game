# Godot Project Conventions

This document outlines the preferred conventions and practices for Godot (GDScript) development within this project, especially concerning how automated agents like Gemini should generate or modify code. The goal is to ensure consistency, maintainability, and clarity.

## I. General Principles

- **Readability**: Prioritize clear, self-documenting code.
- **Performance**: Optimize where necessary, but avoid premature optimization.
- **Modularity**: Design components to be reusable and loosely coupled.
- **Simplicity**: Rely on godot's semantics whenever possible in order to write simpler code.
- **Editor Integration**: Leverage Godot's editor features (e.g., `@export`, scene composition) where appropriate, but be mindful of automation limitations.

## II. Scripting Conventions (GDScript)

### 1. Naming

- **Classes**: `PascalCase` (e.g., `PlayerCharacter`, `EnemyAIController`). Do not use `class_name`, instead have the users import the type.
- **Variables**: `snake_case` (e.g., `player_health`, `attack_interval`).
- **Constants**: `SCREAMING_SNAKE_CASE` (e.g., `MAX_HEALTH`).
- **Functions**: `snake_case` (e.g., `_ready`, `_on_button_pressed`).
- **Signals**: `snake_case` (e.g., `health_changed`).
- **Underscore**: Private and protected functions and variables should start with an underscore, including virtaul functions. Public functions should never start with an underscore, even if they are virtaul.

### 2. Type Hinting

- All function arguments and return types MUST be type-hinted.
- All variables should be type hinted.
- Do not use redundant type hinting - use `:=` if the variable is assigned to a value of a known type during it's creation.

### 3. @export Variables

- Use `@export` for properties intended to be configured via the Inspector in the editor.
- Avoid `var my_variable: Type = value` for `@export` if the value is meant to be configured in the editor. Prefer `var my_variable: Type` or `var my_variable: Type = preload(...)` for resources.

## III. Scene vs. Code

### 1. Node Instantiation (Child Nodes)

- **Preferred (Editor)**: When a node is a permanent part of a scene's hierarchy and its properties are mostly static, add it directly in the `.tscn` file.
- **Preferred (Code)**: When a node is spawned dynamically (e.g., enemies, projectiles), or its creation/destruction is managed by script logic, instantiate and add it via code (e.g., `PackedScene.instantiate()`).

### 2. Signal Connections

- **Preferred (Code)**: Signals should always be connected via code, instead of the editor, unless there is a specific special reason this is undesirable.

### 3. Timers

- **Preferred (Editor)**: Timers will be created by default in the editor (in agent cases, directly in the .tscn files), but their signals will be connected in the code.
- **Code**: If the timer needs to be created dynamically, it can be created from the code.

## IV. Resources

### 1. Custom Resources

- Use `extends Resource` for data-only objects like `Ability` and `StatusEffect`.
- Initialize properties in `_init()` or via setters (e.g., `@export var duration: float: set = set_duration`).

## V. Asset Management

### 1. Asset Paths

- Always use `res://` paths for internal project resources.
- Preload assets (`preload("res://path/to/asset.tscn")`) for performance where appropriate.

---

## VI. Open Questions / To Be Documented:

- **Global vs. Local Input Handling**: When should `InputHandler` be a singleton vs. a scene node?
- **Scene Transition Management**: How should scene transitions (e.g., between Arena and Game Over) be handled?
- **Resource UID Strategy**: How to handle automatic UID generation by Godot vs. manually setting placeholders. (Current agent approach: use placeholders, let editor correct).
