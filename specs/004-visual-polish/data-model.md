# Data Model: Visual Polish & Assets

## New UI Components

### FloatingHealthBar
*   **Type**: `ProgressBar` (or `Control` wrapping it).
*   **Attached To**: `Enemy` scene.
*   **Behavior**:
    *   Updates value when Enemy `health_changed` signal fires.
    *   Positioned above the enemy sprite.

### Background
*   **Type**: `TextureRect`.
*   **Attached To**: `Arena` scene (root).
*   **Z-Index**: -10 (Background).

## Updates to Existing Entities

### Player & Enemy
*   **Components**:
    *   Add `Sprite2D` node.
    *   Assign `human.tres` / `orc.tres`.
    *   Set `scale` to `(4, 4)` (approx).

### TargetIndicator
*   **Visuals**:
    *   Change color to Red (`Color(1, 0, 0, 0.5)`).
    *   Change shape to Circle (using custom draw or sprite).
    *   **Z-Index**: -1 (Behind target).
