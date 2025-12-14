# hud.gd
extends CanvasLayer
class_name HUD

@onready var ability_bar: HBoxContainer = $MainLayout/AbilityBar
@onready var player_health_bar: ProgressBar = $MainLayout/PlayerStats/PlayerHealthBar
@onready var player_health_label: Label = $MainLayout/PlayerStats/PlayerHealthLabel
@onready var player_status_bar: HBoxContainer = $MainLayout/PlayerStats/StatusBar

func _ready() -> void:
	player_health_bar.max_value = 100 # Assuming max health for now
	
	# Clear editor placeholders
	_clear_placeholders(player_status_bar)

func _clear_placeholders(container: Node) -> void:
	for child in container.get_children():
		child.queue_free()

func update_player_health(new_health: float) -> void:
	player_health_bar.value = new_health
	player_health_label.text = "Player Health: %d" % new_health

func add_player_effect(effect: StatusEffect) -> void:
	print("HUD: Adding player effect %s" % effect.name)
	var is_buff = effect.type == StatusEffect.StatusEffectType.BUFF
	player_status_bar.add_effect(effect.name, is_buff, effect.duration)

func remove_player_effect(effect_name: String) -> void:
	player_status_bar.remove_effect(effect_name)

func setup_abilities(abilities: Array) -> void:
	ability_bar.setup(abilities)

func update_abilities(abilities: Array) -> void:
	ability_bar.update_cooldowns(abilities)