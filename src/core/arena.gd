# arena.gd
extends Node2D

@onready var player: Player = $Player
@export var enemy_scene: PackedScene

const FloatingTextScene = preload("res://src/ui/floating_text.tscn")
const EnemyAttackAbility = preload("res://src/abilities/enemy_attack.gd")

func _ready() -> void:
	if player:
		player.connect("damage_taken", func(amount): _on_damage_taken(player, amount))
		spawn_enemy() # Spawn initial enemy
	else:
		push_error("Arena: Player node not found!")

func spawn_enemy() -> void:
	if not enemy_scene:
		push_error("Arena: Enemy scene not set in inspector!")
		return
	
	var new_enemy: Enemy = enemy_scene.instantiate()
	# Find AI controller and set properties BEFORE adding to tree
	var enemy_ai: EnemyAIController = new_enemy.find_child("EnemyAIController")
	add_child(new_enemy) # Add to tree AFTER properties are set
	new_enemy.position = Vector2(800, 500) # Same position as old hardcoded enemy
	new_enemy.character_name = "Spawned Enemy" # For debugging
	
	if enemy_ai:
		enemy_ai.set_target(player)
		enemy_ai.attack_ability = EnemyAttackAbility.new() # Assign the ability instance
		enemy_ai.start_attack_timer() # Start timer after adding to tree
	
	player.target_enemy = new_enemy # Set player's target to the new enemy
	print("Arena: Set Player target to %s." % new_enemy.character_name)
	
	new_enemy.connect("damage_taken", func(amount): _on_damage_taken(new_enemy, amount))
	# Placeholder for other connections like 'died'

func _on_damage_taken(character: Character, amount: float) -> void:
	var text = FloatingTextScene.instantiate()
	add_child(text)
	text.position = character.position + Vector2(0, -50) # Above head
	text.setup(str(int(amount)), Color(1, 0, 0)) # Red text
