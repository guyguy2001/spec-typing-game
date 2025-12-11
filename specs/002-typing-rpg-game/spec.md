# Feature Specification: Typing RPG Game Core Mechanics

**Feature Branch**: `002-typing-rpg-game`  
**Created**: 2025-12-11  
**Status**: Draft  
**Input**: User description: "Build a typing rpg game. The game will be 2d, have a top-down view, and casting abilities will be done via typing words on letters (depending on the mode). The abilities will function like in world of warcraft, where you have a lot of abilities, each with a separate cooldown, and an effect. Some might deal damage, some might apply buffs or debuffs."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Casting a Damage Ability (Priority: P1)

As a player, I want to cast a damage-dealing ability by successfully typing a sequence of characters so that I can defeat enemies.

**Why this priority**: This is the core combat loop and primary interaction method for the player. Without it, the game is not playable.

**Independent Test**: The player can start a combat encounter, successfully cast a single damage ability by typing the required input, and observe the enemy's health decrease. This delivers the fundamental gameplay experience.

**Acceptance Scenarios**:

1.  **Given** a player is in combat with an enemy, **When** the player activates a damage ability and correctly types the associated word/letters, **Then** the ability executes and the enemy takes damage.
2.  **Given** a player is in combat, **When** the player activates a damage ability but makes a mistake while typing, **Then** the ability fails to cast and provides feedback to the player (e.g., a sound, a visual cue).
3.  **Given** a player has cast an ability, **When** they try to cast it again before its cooldown has expired, **Then** the ability is not cast and the UI indicates it is on cooldown.

---

### User Story 2 - Applying a Buff or Debuff (Priority: P2)

As a player, I want to cast abilities that apply beneficial buffs to myself or detrimental debuffs to enemies by typing a sequence of characters.

**Why this priority**: Adds strategic depth to combat beyond simple damage, aligning with the "World of Warcraft-like" ability system.

**Independent Test**: The player can cast a buff on themselves and see a status indicator, or cast a debuff on an enemy and observe a negative effect (e.g., slower movement, damage over time).

**Acceptance Scenarios**:

1.  **Given** a player is in or out of combat, **When** the player casts a buff ability on themselves, **Then** a positive status effect icon appears on their UI for a specific duration.
2.  **Given** a player is in combat with an enemy, **When** the player casts a debuff ability on the enemy, **Then** a negative status effect icon appears on the enemy's UI and its behavior is altered accordingly.

---

### Edge Cases

- **Input Overlap**: What happens if a player types a character that could apply to multiple available ability words? (e.g., 'fireball' and 'fireblast' are both available, player types 'fire'). The system should prioritize the first available match or the shortest word.
- **Rapid Typing**: How does the system handle the player typing faster than the ability animation/cast time? An input queue could be implemented to handle subsequent casts.
- **Typing Timeout**: Is there a time limit to type the word for an ability after initiating it? If so, the cast should fail if the time limit is exceeded.
- **Status Effect Stacking**: How do multiple instances of the same buff or debuff on a single target interact? (e.g., Does the duration reset, or do they stack?). The default behavior should be that the duration resets.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The game MUST present a 2D, top-down view of the game world.
- **FR-002**: Players MUST be able to cast abilities by typing character sequences.
- **FR-003**: Each ability MUST have a unique effect (e.g., dealing damage, applying a buff, applying a debuff).
- **FR-004**: Each ability MUST have an independent cooldown period that begins after a successful cast.
- **FR-005**: The UI MUST clearly display available abilities and their cooldown status.
- **FR-006**: The system MUST provide clear visual feedback for successful and failed ability casts.
- **FR-007**: The typing difficulty MUST progress with the player. Early abilities are cast with a single letter. Later abilities are cast by typing short words, with the cast executed upon pressing the spacebar.
- **FR-008**: Players MUST acquire new abilities from a fixed spellbook that automatically unlocks at pre-defined player levels.
- **FR-009**: The game world MUST consist of a single arena where the player fights against waves of enemies.

### Key Entities

- **Player**: Represents the user's character in the game. Has attributes like health, and a collection of known abilities and active status effects.
- **Ability**: A skill the player can use. Has attributes like a name, typing pattern, effect (damage, buff, etc.), and cooldown time.
- **Enemy**: A non-player character that opposes the player. Has attributes like health and can have status effects applied to it.
- **Status Effect**: A buff or a debuff that temporarily alters the attributes or behavior of a Player or Enemy. Has a duration and an effect.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 95% of correct typing inputs for an available ability result in a successful cast within 100ms.
- **SC-002**: The player can successfully execute the core combat loop (cast ability, see effect, manage cooldown) without encountering blocking bugs.
- **SC-003**: The UI for abilities and cooldowns must be understood by 90% of new players in under 2 minutes of gameplay, based on user testing.
- **SC-004**: The game must maintain a steady 60 frames per second during a typical combat encounter with up to 5 enemies on screen.