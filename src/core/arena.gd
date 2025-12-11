# arena.gd
extends Node2D

@onready var player: Player = $Player
@onready var enemy: Enemy = $Enemy

const FloatingTextScene = preload("res://src/ui/floating_text.tscn")

func _ready() -> void:
    # Wire up the player's target
    if player and enemy:
        player.target_enemy = enemy
        print("Arena: Set Player target to Enemy.")
        
        player.connect("damage_taken", func(amount): _on_damage_taken(player, amount))
        enemy.connect("damage_taken", func(amount): _on_damage_taken(enemy, amount))
    else:
        push_error("Arena: Player or Enemy node not found!")

func _on_damage_taken(character: Character, amount: float) -> void:
    var text = FloatingTextScene.instantiate()
    add_child(text)
    text.position = character.position + Vector2(0, -50) # Above head
    text.setup(str(int(amount)), Color(1, 0, 0)) # Red text

