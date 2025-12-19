# hud.gd
extends CanvasLayer
class_name HUD

@export var player: Player
@export var input_buffer: InputBuffer

@onready var ability_bar: AbilityBar = $MainLayout/AbilityBar
@onready var input_feedback_bar: Label = $MainLayout/InputFeedbackBar
@onready var player_health_bar: ProgressBar = $MainLayout/PlayerStats/PlayerHealthBar
@onready var player_status_bar: HBoxContainer = $MainLayout/PlayerStats/StatusBar

func _ready() -> void:
	player_health_bar.max_value = 100 # Assuming max health for now
		
	player.connect("health_changed", update_player_health)
	player.connect("status_effect_applied", add_player_effect)
	player.connect("status_effect_removed", remove_player_effect)
	player.connect("abilities_changed", setup_abilities)
	setup_abilities(player.abilities)
	input_buffer.input_changed.connect(input_feedback_bar.on_input_changed)
	
	# Clear editor placeholders
	_clear_placeholders(player_status_bar)

func _clear_placeholders(container: Node) -> void:
	for child in container.get_children():
		child.queue_free()

func update_player_health(new_health: float) -> void:
	player_health_bar.value = new_health

func add_player_effect(effect: StatusEffect) -> void:
	print("HUD: Adding player effect %s" % effect.name)
	player_status_bar.add_effect(effect.name, effect.icon, effect.duration)

func remove_player_effect(effect: StatusEffect) -> void:
	player_status_bar.remove_effect(effect.name)

func setup_abilities(abilities: Array) -> void:
	ability_bar.setup(abilities, input_buffer)
