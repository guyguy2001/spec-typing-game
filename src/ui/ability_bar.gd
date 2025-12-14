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
		
		icon.setup(tex, ability.typing_pattern)
		icon_map[ability.name] = icon

func update_cooldowns(abilities: Array) -> void:
	for ability in abilities:
		if icon_map.has(ability.name):
			icon_map[ability.name].update_cooldown(ability.get_cooldown_remaining(), ability.cooldown_duration)
