# Data Model for Typing RPG Game

## Entities

### Player
*   **Description**: Represents the player's character.
*   **Attributes**:
    *   `health`: Integer, current health points.
    *   `max_health`: Integer, maximum health points.
    *   `abilities`: List of `Ability` objects, known by the player.
    *   `active_status_effects`: List of `StatusEffect` objects, currently affecting the player.
    *   `current_typing_input`: String, current input being typed for an ability.
*   **Relationships**:
    *   Has many `Ability` (known abilities).
    *   Has many `StatusEffect` (active effects).

### Ability
*   **Description**: A skill that the player can cast.
*   **Attributes**:
    *   `name`: String, unique identifier for the ability.
    *   `typing_pattern`: String, the character sequence required to cast the ability.
    *   `effect_type`: Enum (Damage, Buff, Debuff), the primary outcome of the ability.
    *   `effect_value`: Float/Integer, magnitude of the effect (e.g., damage amount, buff strength).
    *   `cooldown_duration`: Float, time in seconds before the ability can be cast again.
    *   `current_cooldown`: Float, time remaining on cooldown (0 if ready).
    *   `description`: String, human-readable description of the ability.
*   **Relationships**:
    *   Associated with `Player` (known abilities).
    *   May create `StatusEffect` (buffs/debuffs).

### Enemy
*   **Description**: A non-player character that the player fights.
*   **Attributes**:
    *   `name`: String, unique identifier for the enemy type.
    *   `health`: Integer, current health points.
    *   `max_health`: Integer, maximum health points.
    *   `damage_output`: Integer, base damage dealt by the enemy.
    *   `active_status_effects`: List of `StatusEffect` objects, currently affecting the enemy.
*   **Relationships**:
    *   Has many `StatusEffect` (active effects).

### StatusEffect
*   **Description**: A temporary buff or debuff affecting a `Player` or `Enemy`.
*   **Attributes**:
    *   `name`: String, unique identifier for the effect.
    *   `type`: Enum (Buff, Debuff), indicates beneficial or detrimental.
    *   `duration`: Float, time in seconds the effect will last.
    *   `time_remaining`: Float, time left until the effect expires.
    *   `modifier_type`: Enum (Damage, Speed, Defense, etc.), what attribute is modified.
    *   `modifier_value`: Float/Integer, the value by which the attribute is modified.
*   **Relationships**:
    *   Applied to `Player` or `Enemy`.

## Validation Rules (derived from Requirements)

*   **FR-004**: An `Ability` cannot be cast if its `current_cooldown` is greater than 0.
*   **FR-007**: `Ability.typing_pattern` length should correspond to player level (single letter -> short words).
*   **SC-001**: Typing input for an ability must be an exact match to `Ability.typing_pattern`.

## State Transitions (for `Player`'s `current_typing_input`)

*   **Initial State**: Empty string `""`.
*   **Transition**: Player presses a key -> append key to `current_typing_input`.
*   **Transition**: Player presses Spacebar (for word-based abilities) -> check `current_typing_input` against `Ability.typing_pattern`.
    *   If match: Cast ability, reset `current_typing_input` to `""`.
    *   If no match: Reset `current_typing_input` to `""`.
*   **Transition**: Player makes a mistake (e.g., incorrect character) -> reset `current_typing_input` to `""`.
*   **Transition**: Ability is cast -> reset `current_typing_input` to `""`.
