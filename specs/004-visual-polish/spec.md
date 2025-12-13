# Feature Specification: Visual Polish & Assets

**Feature Branch**: `004-visual-polish`  
**Created**: 2025-12-12  
**Status**: Draft  
**Input**: User description: "Implement visual upgrades including sprite integration, updated target indicator, enemy health bars, and a background image."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Character Visuals (Priority: P1)

As a player, I want to see distinct sprites for myself and the enemies so that I can easily distinguish characters from placeholders.

**Why this priority**: Moves the game from a "greybox" prototype to a visually representative game.

**Independent Test**: The game starts, and the Player and Enemy characters are rendered using their respective sprite assets instead of default placeholders.

**Acceptance Scenarios**:

1.  **Given** the game scene is loaded, **When** the Player character appears, **Then** it uses the sprite located in `sprites/player.png` (or equivalent).
2.  **Given** an Enemy spawns, **When** it appears in the arena, **Then** it uses the sprite located in `sprites/enemy.png` (or equivalent).

---

### User Story 2 - Combat Clarity (Priority: P1)

As a player, I want clearer visual feedback for targeting and enemy health status directly in the game world.

**Why this priority**: Improves combat readability, allowing the player to see who they are targeting and how much health enemies have without looking away from the action.

**Independent Test**: 
1. Select an enemy; a red circle appears behind them. 
2. Damage an enemy; a health bar above their head updates.

**Acceptance Scenarios**:

1.  **Given** the player targets an enemy, **When** the target is selected, **Then** a red circle indicator appears *behind* the enemy sprite.
2.  **Given** an enemy is active, **When** it is on screen, **Then** a small health bar is visible above its head.
3.  **Given** the enemy takes damage, **When** its health decreases, **Then** the floating health bar updates to reflect the new value.

---

### User Story 3 - Environmental Atmosphere (Priority: P2)

As a player, I want to see a background image so that the game feels like it takes place in a specific setting.

**Why this priority**: Sets the mood and removes the "void" feeling of the prototype.

**Independent Test**: The game runs, and a static background image is rendered behind all gameplay elements.

**Acceptance Scenarios**:

1.  **Given** the arena scene loads, **When** the game starts, **Then** a specified background image is visible filling the screen behind characters and UI.

## Requirements *(mandatory)*

### Functional Requirements

-   **FR-001**: The Player scene MUST use the sprite asset provided in the `sprites/` folder.
-   **FR-002**: The Enemy scene MUST use the sprite asset provided in the `sprites/` folder.
-   **FR-003**: The Target Indicator MUST be a red circle visual.
-   **FR-004**: The Target Indicator MUST be rendered *behind* the target character (lower Z-index or earlier in draw order).
-   **FR-005**: Each Enemy entity MUST have a dedicated Health Bar component attached to its scene, positioned above the sprite.
-   **FR-006**: The Arena scene MUST include a `TextureRect` (or similar) for the background image, rendered behind all gameplay elements. [NEEDS CLARIFICATION: Which image file should be used?]

### Key Entities

-   **CharacterSprite**: The visual representation of characters.
-   **FloatingHealthBar**: New UI component attached to enemies.
-   **BackgroundLayer**: A visual layer for the environment.

## Success Criteria *(mandatory)*

### Measurable Outcomes

-   **SC-001**: Characters are visually distinct and recognizable.
-   **SC-002**: Target selection is unambiguous due to the red circle indicator.
-   **SC-003**: Player can determine approximate enemy health without looking at the main HUD.
-   **SC-004**: The background image covers the entire playable area.