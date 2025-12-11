# enemy.gd
extends Character
class_name Enemy

func _ready() -> void:
	super._ready()
	character_name = "Enemy"

func _physics_process(delta: float) -> void:
	# Enemy AI logic will go here.
	# For example, move towards the player.
	# For now, it's empty.
	pass
