extends GutTest

var ArenaScene = load("res://src/core/arena.tscn")
var arena
var player
var enemy
var input_handler
var enemy_ai # New variable for EnemyAIController

func before_each():
	arena = ArenaScene.instantiate()
	add_child_autofree(arena)
	player = arena.get_node("Player")
	# Get the enemy from the player's target, as Arena spawns new enemies
	enemy = player.target_enemy
	assert_not_null(enemy, "Player should have a target after Arena setup")
	input_handler = arena.get_node("InputHandler")
	enemy_ai = enemy.get_node("EnemyAIController")
	assert_not_null(enemy_ai, "Enemy should have an EnemyAIController attached")

func test_damage_ability():
	# Verify initial state of enemy
	assert_eq(enemy.health, enemy.max_health, "Enemy should start at max health")
	
	# Verify initial state of player for enemy attack
	var initial_player_health = player.health
	assert_eq(initial_player_health, player.max_health, "Player should start at max health")

	# Simulate player casting "fire" on enemy
	_simulate_typing("fire")
	_simulate_key(KEY_SPACE)
	
	# Assert enemy health decreased after player's cast
	assert_lt(enemy.health, enemy.max_health, "Enemy health should decrease after 'fire' cast")
	
	# --- Now test enemy attacking player ---
	# Allow time for enemy's timer to trigger attack (wait_time is 3.0s)
	wait_seconds(4.0) 
	enemy_ai._on_attack_timer_timeout() # Manually trigger attack for test
	
	# Assert player health decreased after enemy's cast
	assert_lt(player.health, initial_player_health, "Player health should decrease after enemy's attack")

func _simulate_typing(text: String):
	for i in text.length():
		var char_code = text.unicode_at(i)
		var event = InputEventKey.new()
		event.pressed = true
		event.unicode = char_code
		input_handler._input(event)

func _simulate_key(keycode: int):
	var event = InputEventKey.new()
	event.pressed = true
	event.keycode = keycode
	input_handler._input(event)
