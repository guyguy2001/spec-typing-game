# Project Structure

This document outlines the file structure of the `spec-typing-game` project and provides brief descriptions for the source code files.

## Directory Layout

```text
spec-typing-game/
├── addons/         # Third-party plugins (GUT for testing)
├── assets/         # Game assets (images, sounds, etc.)
├── resources/      # Godot Resource files (.tres)
├── specs/          # Project specifications and documentation
├── sprites/        # Sprite assets
├── src/            # Source code
│   ├── abilities/  # Ability definitions and effects
│   ├── ai/         # AI controllers
│   ├── characters/ # Character logic (Player, Enemy)
│   ├── core/       # Core systems (Arena, Input, State Machine)
│   └── ui/         # User Interface components
└── tests/          # Unit and integration tests
```

## File Descriptions

### `src/abilities/`
*   **`ability.gd`**: A resource defining an ability's properties, cooldown, and casting logic.
*   **`effects/buff_effect.gd`**: An ability effect that applies a status effect (buff) to the target.
*   **`effects/damage_effect.gd`**: An ability effect that deals direct damage to the target.
*   **`effects/effect.gd`**: A base resource class for defining the effect logic of an ability.

### `src/ai/`
*   **`enemy_ai_controller.gd`**: A controller that manages enemy behavior, specifically attacking the player at intervals.

### `src/characters/`
*   **`character.gd`**: A base class for all characters (player and enemies) handling health, damage, and status effects.
*   **`enemy.gd`**: An enemy character class that extends the base character.
*   **`player.gd`**: The player character class handling typing input to cast abilities and managing player specific logic.

### `src/core/`
*   **`arena.gd`**: The main game scene manager that handles spawning enemies, managing the player, and combat flow.
*   **`input_handler.gd`**: A node that captures and emits signals for keyboard input, including text typing and specific keys.
*   **`state.gd`**: A base class for state nodes to be used within the `StateMachine`.
*   **`state_machine.gd`**: A generic state machine node that manages transitions between different state nodes.
*   **`status_effect.gd`**: A resource defining a temporary modification to a character's stats (buff or debuff).

### `src/ui/`
*   **`ability_bar.gd`**: A container that manages and updates the visual representation of the player's available abilities.
*   **`ability_icon.gd`**: A UI element representing a single ability, showing its icon, hotkey/pattern, and cooldown overlay.
*   **`floating_health_bar.gd`**: A progress bar that floats above a character to display their health and active status effects.
*   **`floating_text.gd`**: A label that floats upwards and fades out, used for displaying damage numbers or other text feedback.
*   **`game_over.gd`**: A control handling the game over screen and restart functionality.
*   **`hud.gd`**: The main Heads-Up Display managing the player's health bar, status bar, and ability icons.
*   **`status_bar.gd`**: A container for managing and displaying multiple status effect icons.
*   **`status_icon.gd`**: A UI element displaying a status effect's icon and a visual indicator of its remaining duration.
*   **`target_indicator.gd`**: A visual indicator (circle) drawn below the currently targeted character.

### `tests/`
*   **`integration/test_combat_flow.gd`**: An integration test verifying the combat loop, including ability casting and damage application.

### `addons/`
*   **`gut/`**: Contains the GUT (Godot Unit Test) framework scripts.
