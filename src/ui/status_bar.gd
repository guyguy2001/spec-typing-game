# status_bar.gd
extends HBoxContainer

const StatusIconScene = preload("res://src/ui/status_icon.tscn")

@export var character: Character

var active_icons: Dictionary = {}

func _ready() -> void:
	# Remove placeholders
	for child in get_children():
		child.queue_free()

	character.status_effect_applied.connect(add_effect)
	character.status_effect_removed.connect(remove_effect)

func add_effect(effect: StatusEffect) -> void:
	if active_icons.has(effect.name):
		# TODO: Do I even want this case? I think I just want to refresh the duration.
		# Why does this function even receive such a complex thing?
		active_icons[effect.name].setup(effect)
		return
		
	var icon = StatusIconScene.instantiate()
	add_child(icon)
	icon.setup(effect)
	active_icons[effect.name] = icon

func remove_effect(effect: StatusEffect) -> void:
	if active_icons.has(effect.name):
		var icon = active_icons[effect.name]
		icon.queue_free()
		active_icons.erase(effect.name)
