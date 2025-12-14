# ability_bar.gd
extends HBoxContainer

const IconScene = preload("res://src/ui/ability_icon.tscn")

var icon_map = {}

func setup(abilities: Array, input_buffer: InputBuffer) -> void:
	# Remove placeholders
	for child in get_children():
		child.queue_free()
	icon_map.clear()
	
	for ability in abilities:
		var tex = ability.icon

		var icon = IconScene.instantiate()
		add_child(icon)
		
		icon.setup(tex, ability, input_buffer)
		icon_map[ability.name] = icon
