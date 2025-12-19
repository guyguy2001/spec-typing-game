# hud.gd
extends CanvasLayer
class_name HUD

@export var player: Player
@export var input_buffer: InputBuffer

@onready var ability_bar: AbilityBar = $MainLayout/AbilityBar
@onready var input_feedback_bar: Label = $MainLayout/InputFeedbackBar
@onready var player_health_bar: ProgressBar = $MainLayout/PlayerStats/PlayerHealthBar


func _ready() -> void:
	player_health_bar.max_value = 100 # Assuming max health for now
		
	player.connect("health_changed", update_player_health)
	player.connect("abilities_changed", setup_abilities)
	setup_abilities(player.abilities)
	input_buffer.input_changed.connect(input_feedback_bar.on_input_changed)


func update_player_health(new_health: float) -> void:
	player_health_bar.value = new_health

func setup_abilities(abilities: Array) -> void:
	ability_bar.setup(abilities, input_buffer)
