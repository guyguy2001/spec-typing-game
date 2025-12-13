# enemy.gd
extends Character
class_name Enemy

@onready var health_bar: FloatingHealthBar = $FloatingHealthBar

func _ready() -> void:
	super._ready()
	character_name = "Enemy"
	if health_bar:
		health_bar.update_health(health, max_health)
		connect("health_changed", Callable(self, "_on_health_changed"))

func _on_health_changed(new_health: float) -> void:
	if health_bar:
		health_bar.update_health(new_health, max_health)

func _physics_process(delta: float) -> void:
	# Enemy AI logic will go here.
	# For example, move towards the player.
	# For now, it's empty.
	pass