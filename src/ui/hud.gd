# hud.gd
extends CanvasLayer
class_name HUD

@onready var player_health_bar: ProgressBar = $MainLayout/PlayerStats/PlayerHealthBar
@onready var player_health_label: Label = $MainLayout/PlayerStats/PlayerHealthLabel
@onready var enemy_health_bar: ProgressBar = $MainLayout/EnemyStats/EnemyHealthBar
@onready var enemy_health_label: Label = $MainLayout/EnemyStats/EnemyHealthLabel

func _ready() -> void:
	player_health_bar.max_value = 100 # Assuming max health for now
	enemy_health_bar.max_value = 100 # Assuming max health for now

func update_player_health(new_health: float) -> void:
	player_health_bar.value = new_health
	player_health_label.text = "Player Health: %d" % new_health

func update_enemy_health(new_health: float) -> void:
	enemy_health_bar.value = new_health
	enemy_health_label.text = "Enemy Health: %d" % new_health
