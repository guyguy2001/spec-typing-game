# floating_health_bar.gd
extends ProgressBar
class_name FloatingHealthBar

const StatusIconScene = preload("res://src/ui/status_icon.tscn")

@export var character: Character

func _ready() -> void:
	show_percentage = false
	_update_health(character.health, character.max_health)
	character.connect("health_changed", Callable(self, "_update_health"))

func _update_health(max_health: float, new_health: float) -> void:
	max_value = max_health
	value = new_health
