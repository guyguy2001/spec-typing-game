# floating_health_bar.gd
extends ProgressBar
class_name FloatingHealthBar

const StatusIconScene = preload("res://src/ui/status_icon.tscn")

@export var character: Character

@onready var status_bar: HBoxContainer = $StatusBar

var active_icons: Dictionary = {}

func _ready() -> void:
	show_percentage = false
	_update_health(character.health, character.max_health)
	character.connect("health_changed", Callable(self, "_update_health"))
	character.connect("status_effect_applied", Callable(self, "_add_status_effect"))
	character.connect("status_effect_removed", Callable(self, "_remove_status_effect"))

	# Remove placeholders
	for child in status_bar.get_children():
		child.queue_free()

func _update_health(max_health: float, new_health: float) -> void:
	max_value = max_health
	value = new_health

func _add_status_effect(effect: StatusEffect) -> void:
	print("Adding", effect.name)
	if active_icons.has(effect.name):
		print("Already has ", effect.name)
		# Update existing
		var icon = active_icons[effect.name]
		icon.setup(effect.name, effect.icon, effect.duration)
		return

	print("Doesn't have has ", effect.name)
	var icon = StatusIconScene.instantiate()
	status_bar.add_child(icon)
	icon.setup(effect.name, effect.icon, effect.duration)
	active_icons[effect.name] = icon

func _remove_status_effect(effect: StatusEffect) -> void:
	print("Remove", effect.name)
	if active_icons.has(effect.name):
		var icon = active_icons[effect.name]
		icon.queue_free()
		active_icons.erase(effect.name)
