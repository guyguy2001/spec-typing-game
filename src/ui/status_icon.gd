# status_icon.gd
extends TextureRect

class_name StatusEffectIcon

var effect: StatusEffect

@onready var duration_overlay: TextureProgressBar = $DurationOverlay
@onready var label: Label = $Label

func setup(p_effect: StatusEffect) -> void:
	effect = p_effect

	texture = effect.icon
	tooltip_text = effect.name
	
	duration_overlay.max_value = effect.duration
	duration_overlay.value = effect.time_remaining

func _process(_delta: float) -> void:
	duration_overlay.value = effect.time_remaining
	if duration_overlay.value <= 0:
		modulate.a = 0.5 # Visual cue that it's expiring
