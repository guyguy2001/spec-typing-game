# arena.gd
extends Node2D

@onready var player: Player = $Player
@onready var enemy: Enemy = $Enemy

func _ready() -> void:
    # Wire up the player's target
    if player and enemy:
        player.target_enemy = enemy
        print("Arena: Set Player target to Enemy.")
    else:
        push_error("Arena: Player or Enemy node not found!")
