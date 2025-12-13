# status_bar.gd
extends HBoxContainer

const StatusIconScene = preload("res://src/ui/status_icon.tscn")

# Dictionary to map effect names to their icon nodes
var active_icons: Dictionary = {}

func add_effect(effect_name: String, is_buff: bool = true) -> void:
	if active_icons.has(effect_name):
		return # Already showing
		
	var icon = StatusIconScene.instantiate()
	add_child(icon)
	icon.setup(effect_name, is_buff)
	active_icons[effect_name] = icon
	print("Added icon %s" % icon)

func remove_effect(effect_name: String) -> void:
	print("Removing %s" % effect_name)
	if active_icons.has(effect_name):
		var icon = active_icons[effect_name]
		icon.queue_free()
		active_icons.erase(effect_name)
