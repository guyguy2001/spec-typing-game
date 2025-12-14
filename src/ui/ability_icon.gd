# ability_icon.gd
extends TextureRect

@export var ability: Ability

@onready var pre_cast_indicator: Control = $PreCastIndicator
@onready var cooldown_overlay: TextureProgressBar = $CooldownOverlay
@onready var label: Label = $Label

func setup(p_texture: Texture2D, p_ability) -> void:
	texture = p_texture
	ability = p_ability

	label.text = p_ability.typing_pattern
	cooldown_overlay.value = 0

func _process(_delta):
	if ability.cooldown_duration > 0:
		cooldown_overlay.max_value = ability.cooldown_duration
		cooldown_overlay.value = ability.current_cooldown
	else:
		cooldown_overlay.value = 0
	pre_cast_indicator.visible = ability.pre_casting != null