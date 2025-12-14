# status_icon.gd
extends TextureRect

@onready var duration_overlay: TextureProgressBar = $DurationOverlay
@onready var label: Label = $Label

func setup(effect_name: String, icon_texture: Texture2D, duration: float) -> void:
	texture = icon_texture
	tooltip_text = effect_name
	
	duration_overlay.max_value = duration
	duration_overlay.value = duration

func _process(delta: float) -> void:
	duration_overlay.value -= delta
	if duration_overlay.value <= 0:
		modulate.a = 0.5 # Visual cue that it's expiring
