# status_icon.gd
extends TextureRect

@onready var duration_overlay: TextureProgressBar = $DurationOverlay
@onready var label: Label = $Label

# Preload default icons
const BuffIcon = preload("res://assets/sprites/ui/icons/Classes/HolyDarkness/Priest/Priest8.png")
const DebuffIcon = preload("res://assets/sprites/ui/icons/Classes/Elementalist/Cryomancer/Cryomancer4.png")

func setup(effect_name: String, is_buff: bool, duration: float) -> void:
	if is_buff:
		texture = BuffIcon
	else:
		texture = DebuffIcon
	
	tooltip_text = effect_name
	
	duration_overlay.max_value = duration
	duration_overlay.value = duration

func update_duration(remaining: float) -> void:
	duration_overlay.value = remaining