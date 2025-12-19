# ability_icon.gd
extends TextureRect

@export var ability: Ability

@onready var pre_cast_indicator: Control = $PreCastIndicator
@onready var cooldown_overlay: TextureProgressBar = $CooldownOverlay
@onready var typable_label: TypableLabel = $Label

func setup(p_texture: Texture2D, p_ability, input_buffer: InputBuffer) -> void:
	texture = p_texture
	ability = p_ability

	typable_label.target_text = p_ability.typing_pattern
	input_buffer.input_changed.connect(typable_label.on_input_changed)
	cooldown_overlay.value = 0

func _process(_delta):
	if ability.cooldown_duration > 0:
		cooldown_overlay.max_value = ability.cooldown_duration
		cooldown_overlay.value = ability.current_cooldown
	else:
		cooldown_overlay.value = 0
	pre_cast_indicator.visible = ability.pre_casting != null
