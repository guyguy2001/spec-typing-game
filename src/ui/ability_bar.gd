# ability_bar.gd
extends HBoxContainer

const IconScene = preload("res://src/ui/ability_icon.tscn")

var icon_map = {}

func setup(abilities: Array) -> void:
	for child in get_children():
		child.queue_free()
	icon_map.clear()
	
	for ability in abilities:
		var icon = IconScene.instantiate()
		add_child(icon)
		
		# Use icon from the ability resource
		var tex = ability.icon
		
		icon.setup(tex, ability)
		icon_map[ability.name] = icon
