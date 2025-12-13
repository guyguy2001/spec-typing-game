# status_icon.gd
extends ColorRect

@onready var label: Label = $Label

func setup(effect_name: String, is_buff: bool) -> void:
	label.text = effect_name.left(3) # Show first 3 chars
	if is_buff:
		color = Color(0.2, 0.8, 0.2) # Green for buffs
	else:
		color = Color(0.8, 0.2, 0.2) # Red for debuffs
