# floating_health_bar.gd
extends ProgressBar
class_name FloatingHealthBar

func _ready() -> void:
	show_percentage = false # Don't show text on the bar itself

func update_health(new_health: float, max_health: float) -> void:
	max_value = max_health
	value = new_health
