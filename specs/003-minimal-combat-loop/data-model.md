# Data Model: Minimal Combat Loop

## New Entities

### EnemyAIController
*   **Description**: Logic component attached to Enemy scenes to drive behavior.
*   **Attributes**:
    *   `attack_timer`: Timer node.
    *   `attack_interval`: Float (seconds between attacks).
    *   `ability_to_cast`: Ability resource.
*   **Behaviors**:
    *   On Timer timeout -> Cast `ability_to_cast` on Player.

### TargetIndicator
*   **Description**: Visual marker for the selected enemy.
*   **Attributes**:
    *   `target`: Node (The enemy being highlighted).
*   **Behaviors**:
    *   Follows `target` position.
    *   Visible only when `target` is valid.

## Updates to Existing Entities

### Arena (Arena.gd)
*   **New State**:
    *   `enemies`: Array[Enemy] (List of active enemies).
    *   `wave_number`: Integer.
*   **New Behaviors**:
    *   `spawn_enemy()`: Instantiates enemy at spawn point.
    *   `_on_enemy_died()`: Handles cleanup and respawn timer.
    *   `_on_player_died()`: Triggers Game Over.

### InputHandler
*   **New Signals**:
    *   `tab_pressed()`: For cycling targets.

### Player
*   **Updates**:
    *   `target_enemy`: Now cycles through `Arena.enemies` on Tab.
