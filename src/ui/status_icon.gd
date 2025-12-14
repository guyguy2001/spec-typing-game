# status_icon.gd
extends TextureRect

@onready var duration_overlay: TextureProgressBar = $DurationOverlay
@onready var label: Label = $Label

func setup(effect_name: String, icon_texture: Texture2D, duration: float) -> void:
	texture = icon_texture
	tooltip_text = effect_name
	
	duration_overlay.max_value = duration
	duration_overlay.value = duration

func update_duration(remaining: float) -> void:
	duration_overlay.value = remaining