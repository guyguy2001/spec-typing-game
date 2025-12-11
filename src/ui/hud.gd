# hud.gd
extends CanvasLayer
class_name HUD

@onready var ability_list: Label = $MainLayout/AbilityList
@onready var player_health_bar: ProgressBar = $MainLayout/PlayerStats/PlayerHealthBar
@onready var player_health_label: Label = $MainLayout/PlayerStats/PlayerHealthLabel
@onready var player_status_bar: HBoxContainer = $MainLayout/PlayerStats/StatusBar

@onready var enemy_health_bar: ProgressBar = $MainLayout/EnemyStats/EnemyHealthBar
@onready var enemy_health_label: Label = $MainLayout/EnemyStats/EnemyHealthLabel
@onready var enemy_status_bar: HBoxContainer = $MainLayout/EnemyStats/StatusBar

func _ready() -> void:
    player_health_bar.max_value = 100 # Assuming max health for now
    enemy_health_bar.max_value = 100 # Assuming max health for now
    
    # Clear editor placeholders
    _clear_placeholders(player_status_bar)
    _clear_placeholders(enemy_status_bar)

func _clear_placeholders(container: Node) -> void:
    for child in container.get_children():
        child.queue_free()

func update_player_health(new_health: float) -> void:
    player_health_bar.value = new_health
    player_health_label.text = "Player Health: %d" % new_health

func update_enemy_health(new_health: float) -> void:
    enemy_health_bar.value = new_health
    enemy_health_label.text = "Enemy Health: %d" % new_health

func add_player_effect(effect_name: String) -> void:
    print("HUD: Adding player effect %s" % effect_name)
    player_status_bar.add_effect(effect_name, true) # Assume buff for now

func remove_player_effect(effect_name: String) -> void:
    player_status_bar.remove_effect(effect_name)

func add_enemy_effect(effect_name: String) -> void:
    print("HUD: Adding enemy effect %s" % effect_name)
    enemy_status_bar.add_effect(effect_name, false) # Assume debuff for now

func remove_enemy_effect(effect_name: String) -> void:
    enemy_status_bar.remove_effect(effect_name)

func update_ability_list(text: String) -> void:
    ability_list.text = text