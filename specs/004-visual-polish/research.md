# Research: Visual Polish & Assets

## Asset Strategy

**Character Sprites**:
- **Source**: `res://sprites/roguelikeChar_transparent.png` (Atlas).
- **Player**: `res://sprites/human.tres` (16x16 AtlasTexture).
- **Enemy**: `res://sprites/orc.tres` (16x16 AtlasTexture).
- **Scaling**: Due to small source size (16px), sprites must be scaled up (approx 4x-6x) in their scenes to be clearly visible.

**Background**:
- **Status**: Pending user input.
- **Implementation**: Will use a `TextureRect` in `Arena.tscn` behind all characters.
- **Placeholder**: A solid color or simple gradient `ColorRect` can serve as a placeholder if no image is provided.

**Target Indicator**:
- **Design**: Red circle behind the enemy.
- **Implementation**: `TargetIndicator` scene needs to be updated. It currently uses a `ColorRect` (yellow). Will change to a red circle (using `draw_circle` in `_draw` or a circular sprite).
- **Z-Index**: Must be lower than the character sprite to appear "behind".

**Enemy Health Bar**:
- **Implementation**: `ProgressBar` node attached to `Enemy` scene.
- **Visibility**: Always visible or only on damage? Spec says "small health bar above its head".
