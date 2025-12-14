# status_bar.gd
extends HBoxContainer

const StatusIconScene = preload("res://src/ui/status_icon.tscn")

var active_icons: Dictionary = {}

func add_effect(effect_name: String, icon_texture: Texture2D, duration: float) -> void:
	if active_icons.has(effect_name):
		var icon = active_icons[effect_name]
		icon.setup(effect_name, icon_texture, duration)
		return
		
	var icon = StatusIconScene.instantiate()
	add_child(icon)
	icon.setup(effect_name, icon_texture, duration)
	active_icons[effect_name] = icon

func remove_effect(effect_name: String) -> void:
	if active_icons.has(effect_name):
		var icon = active_icons[effect_name]
		icon.queue_free()
		active_icons.erase(effect_name)

func _process(delta: float) -> void:
	for icon in active_icons.values():
		icon.update_duration(icon.duration_overlay.value - delta)
