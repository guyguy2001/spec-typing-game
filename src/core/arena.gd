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
    add_child(new_enemy)
    new_enemy.position = Vector2(800, 500) # Same position as old hardcoded enemy
    new_enemy.character_name = "Spawned Enemy" # For debugging
    
    player.target_enemy = new_enemy # Set player's target to the new enemy
    print("Arena: Set Player target to %s." % new_enemy.character_name)
    
    var enemy_ai: EnemyAIController = new_enemy.find_child("EnemyAIController")
    if enemy_ai:
        enemy_ai.set_target(player)
        enemy_ai.attack_ability = EnemyAttackAbility.new() # Assign the ability instance
        print("Arena: Set EnemyAIController target to Player and assigned ability.")
    else:
        push_error("Arena: EnemyAIController not found on spawned enemy!")
    
    new_enemy.connect("damage_taken", func(amount): _on_damage_taken(new_enemy, amount))
    # Placeholder for other connections like 'died'

func _on_damage_taken(character: Character, amount: float) -> void:
    var text = FloatingTextScene.instantiate()
    add_child(text)
    text.position = character.position + Vector2(0, -50) # Above head
    text.setup(str(int(amount)), Color(1, 0, 0)) # Red text

