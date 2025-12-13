# ability_icon.gd
extends TextureRect

@onready var cooldown_overlay: TextureProgressBar = $CooldownOverlay
@onready var label: Label = $Label

func setup(p_texture: Texture2D, p_text: String) -> void:
	texture = p_texture
	label.text = p_text
	cooldown_overlay.value = 0

func update_cooldown(remaining: float, max_duration: float) -> void:
	if max_duration > 0:
		cooldown_overlay.max_value = max_duration
		cooldown_overlay.value = remaining
	else:
		cooldown_overlay.value = 0
