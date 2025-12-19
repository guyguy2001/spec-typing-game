# arena.gd
extends Node2D

@onready var player: Player = $Player
@onready var respawn_timer: Timer = $RespawnTimer
@onready var input_buffer: InputBuffer = $InputBuffer


@export var enemy_scene: PackedScene
@export var game_over_ui_scene: PackedScene # Scene for Game Over UI
@export var target_indicator_scene: PackedScene

const FloatingTextScene = preload("res://src/ui/floating_text.tscn")

var enemies: Array[Enemy] = []
var target_indicator: TargetIndicator = null
var spawn_points: Array[Node] = []

func _ready() -> void:
	# Instantiate InputBuffer
	target_indicator = target_indicator_scene.instantiate() as TargetIndicator
	add_child(target_indicator)

	player.connect("damage_taken", Callable(self, "_on_damage_taken").bind(player))
	player.connect("died", Callable(self, "_on_player_died"))
	player.target_changed.connect(_on_player_target_changed)
	
	if respawn_timer:
		respawn_timer.one_shot = true
		respawn_timer.wait_time = 1.0 # 1 second delay before respawning
		respawn_timer.connect("timeout", Callable(self, "_on_respawn_timer_timeout"))
	else:
		push_error("Arena: RespawnTimer node not found! Please add a Timer node named 'RespawnTimer' in the scene.")
	
	# Get spawn points
	spawn_points = get_tree().get_nodes_in_group("spawn_point")
	
	# Spawn initial enemies
	spawn_enemy(spawn_points[0].position)
	spawn_enemy(spawn_points[1].position)

	if not enemies.is_empty():
		_set_player_target(enemies[0])

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("switch_target"):
		cycle_target()

func _on_player_target_changed(target: Character):
	target_indicator.target_node = target

func spawn_enemy(spawn_pos: Vector2 = Vector2(800, 500)) -> void:
	if not enemy_scene:
		push_error("Arena: Enemy scene not set in inspector!")
		return
	
	var new_enemy: Enemy = enemy_scene.instantiate()
	
	add_child(new_enemy)
	new_enemy.position = spawn_pos
	new_enemy.character_name = "Enemy %d" % enemies.size()
	
	player.target_enemy = new_enemy # Set player's target to the new enemy
	
	new_enemy.connect("damage_taken", Callable(self, "_on_damage_taken").bind(new_enemy))
	new_enemy.connect("died", Callable(self, "_on_enemy_died").bind(new_enemy))
	
	enemies.append(new_enemy)
	
	# Auto-target if it's the first one
	if player.target_enemy == null:
		_set_player_target(new_enemy)

func cycle_target() -> void:
	if enemies.is_empty():
		return
	
	var current_index = enemies.find(player.target_enemy)
	var next_index = (current_index + 1) % enemies.size()
	_set_player_target(enemies[next_index])

func _set_player_target(enemy: Enemy) -> void:
	player.target_enemy = enemy

func _on_damage_taken(amount: float, character: Character) -> void: # Signature changed
	var text = FloatingTextScene.instantiate()
	add_child(text)
	text.position = character.position + Vector2(0, -50)
	text.setup(str(int(amount)), Color(1, 0, 0))

func _on_enemy_died(enemy_node: Enemy) -> void:
	print("Enemy died!")
	# Disconnect from the dying enemy
	enemy_node.disconnect("damage_taken", Callable(self, "_on_damage_taken").bind(enemy_node))
	enemy_node.disconnect("died", Callable(self, "_on_enemy_died").bind(enemy_node))
	
	enemies.erase(enemy_node)
	
	if player.target_enemy == enemy_node:
		if not enemies.is_empty():
			_set_player_target(enemies[0])
		else:
			_set_player_target(null)
			if target_indicator: target_indicator.target_node = null
	
	enemy_node.queue_free()
	
	respawn_timer.start()


func _on_respawn_timer_timeout() -> void:
	var spawn_pos = Vector2(randf_range(600, 900), randf_range(300, 600))
	if not spawn_points.is_empty():
		var random_point = spawn_points[randi() % spawn_points.size()]
		spawn_pos = random_point.position
	
	spawn_enemy(spawn_pos)

func _on_player_died() -> void:
	print("Player died! Game Over.")
	get_tree().paused = true
	if game_over_ui_scene:
		var game_over_ui = game_over_ui_scene.instantiate()
		add_child(game_over_ui)
	else:
		push_error("Arena: Game Over UI scene not set!")
