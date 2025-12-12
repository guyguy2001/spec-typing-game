# Research: Minimal Combat Loop

## Targeting System

**Decision**: Implement **Tab Targeting** for the MVP.

**Rationale**:
- **Familiarity**: Matches the "WoW-like" inspiration.
- **Simplicity**: Avoids input conflicts between typing spells and selecting enemies.
- **Speed**: Allows rapid prototype validation of the combat loop without building a complex input parser.

**Future Considerations (Typing-Based Targeting)**:
- As noted in the spec, we intend to explore typing-based targeting later.
- Architecture should allow swapping the input handling logic.
- Potential conflict: If an enemy is named "Orc" and a spell is "Orb", typing 'O' is ambiguous. Solutions include:
    - Dedicated "Target Mode" toggle.
    - Unique prefixes for targets.
    - Contextual parsing.

## Enemy AI

**Decision**: Simple **Timer-based State Machine**.

**Rationale**:
- Sufficient for MVP.
- Enemy waits X seconds, then casts an ability.
- No complex pathfinding required yet (Arena is static).

## Game Loop

**Decision**: **Wave System** managed by `Arena.gd`.

**Rationale**:
- `Arena.gd` already owns the enemy instance.
- It can listen for `died` signal, `queue_free` the old enemy, and `instantiate` a new one.
- Keeps logic centralized.
