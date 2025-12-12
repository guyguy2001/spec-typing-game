# Feature Specification: Minimal Combat Loop

**Feature Branch**: `003-minimal-combat-loop`  
**Created**: 2025-12-12  
**Status**: Draft  
**Input**: User description: "Implement a minimal combat loop with enemy AI attacking back, respawning waves, game over state, and multi-enemy tab targeting."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Enemy Fights Back (Priority: P1)

As a player, I want the enemy to attack me periodically so that there is a challenge and I must use my abilities strategically.

**Why this priority**: Introduces basic combat challenge and tests the core damage dealing and healing mechanics.

**Independent Test**: The player can start the arena scene, an enemy will periodically attack the player, and the player's health will decrease and be reflected on the HUD.

**Acceptance Scenarios**:

1.  **Given** the game is running and an enemy is present, **When** a set amount of time passes, **Then** the enemy executes an attack on the player.
2.  **Given** the enemy attacks the player, **When** the player's health drops to 0 or below, **Then** the game over state is triggered.

---

### User Story 2 - Continuous Combat (Priority: P1)

As a player, I want to continuously fight new enemies after defeating one so that I can practice my typing and ability rotation.

**Why this priority**: Establishes a basic, repeatable combat loop for immediate gameplay testing.

**Independent Test**: The player can defeat an enemy, and a short time later, a new enemy instance appears, ready for combat.

**Acceptance Scenarios**:

1.  **Given** an enemy's health drops to 0 or below, **When** the enemy dies, **Then** a visual death effect plays, and a new enemy instance is spawned after a short delay.
2.  **Given** a new enemy is spawned, **When** it appears, **Then** it immediately begins its attack pattern.

---

### User Story 3 - Game Over State (Priority: P1)

As a player, I want to see a clear "Game Over" indication when my health reaches zero, and have an option to restart.

**Why this priority**: Provides essential feedback for failure and a clear path to re-engage with the game.

**Independent Test**: The player's health can be reduced to zero, triggering a "Game Over" screen with a restart option.

**Acceptance Scenarios**:

1.  **Given** the player's health drops to 0 or below, **When** the player dies, **Then** game logic is paused, a "Game Over" message is displayed, and a "Restart" button is presented.
2.  **Given** the "Game Over" screen is displayed, **When** the player clicks "Restart", **Then** the game scene is reloaded, and combat restarts.

---

### User Story 4 - Multi-Enemy Targeting (Priority: P2)

As a player, I want to fight multiple enemies and be able to select a specific target among them using a hotkey.

**Why this priority**: Introduces a key tactical element and allows for testing the ability system against multiple foes.

**Independent Test**: The game starts with multiple enemies, and the player can cycle through them with a keypress, observing a visual indicator on the currently selected target.

**Acceptance Scenarios**:

1.  **Given** multiple enemies are present in the arena, **When** the player presses the `TAB` key, **Then** the `target_enemy` cycles to the next living enemy.
2.  **Given** an enemy is selected as `target_enemy`, **When** the `TAB` key is pressed, **Then** a visual indicator (e.g., a colored outline or an arrow) moves to the new `target_enemy`.
3.  **Given** the player casts an ability that requires a target, **When** the ability is cast, **Then** it affects the currently selected `target_enemy`.

---

### Edge Cases

-   What happens if there are no enemies left to target? (Player's `target_enemy` should become `null`, or the game transitions to a victory state - *will be handled implicitly by respawn logic for now*).
-   How does targeting behave if all enemies are dead but a new one hasn't spawned yet? (`target_enemy` remains `null` temporarily).
-   What happens if the last targeted enemy dies? (Target should cycle to the next available enemy automatically if possible).

## Requirements *(mandatory)*

### Functional Requirements

-   **FR-001**: The Enemy MUST periodically attack the Player using a `DamageAbility`.
-   **FR-002**: Upon an Enemy's defeat, a new Enemy instance MUST be spawned after a short delay.
-   **FR-003**: The game MUST implement a "Game Over" state triggered by the Player's defeat.
-   **FR-004**: A "Game Over" screen MUST display a message and offer a "Restart" option.
-   **FR-005**: The game MUST support multiple Enemy instances simultaneously in the arena.
-   **FR-006**: Players MUST be able to cycle through living Enemy targets using the `TAB` key.
-   **FR-007**: A visual indicator MUST clearly highlight the currently selected `target_enemy`.
-   **FR-008**: Player-cast targeted abilities MUST affect the `target_enemy`.

### Key Entities

-   **EnemyAIController**: Script/component responsible for enemy decision-making and attack timing.
-   **TargetIndicator**: Visual element to highlight the currently selected enemy.
-   **GameOverUI**: UI scene for displaying game over state and restart options.

## Success Criteria *(mandatory)*

### Measurable Outcomes

-   **SC-001**: The Player can be defeated by enemies within a typical play session (e.g., 1-5 minutes).
-   **SC-002**: Enemies respawn consistently after defeat, allowing for continuous combat.
-   **SC-003**: The "Game Over" screen is presented correctly upon player defeat and the "Restart" button functions.
-   **SC-004**: The player can successfully switch targets between multiple enemies using the `TAB` key.
-   **SC-005**: All targeted abilities correctly affect the currently selected enemy.

## Notes & Future Considerations

-   **Typing-Based Targeting**: In the future, the user intends to explore a "typing of the dead" style targeting system where enemies can be targeted by typing words associated with them. The current Tab-targeting implementation should be designed to be replaceable or configurable to allow for this alternative targeting method.
-   **Combat Complexity**: This feature focuses on minimal combat. Future enhancements could include different enemy types, movement patterns, varied abilities, and environmental hazards.