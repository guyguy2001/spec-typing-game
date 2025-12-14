# enemy.gd
extends Character
class_name Enemy

@onready var health_bar: FloatingHealthBar = $FloatingHealthBar

func _ready() -> void:
	super._ready()
	character_name = "Enemy"
