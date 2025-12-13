# ability_bar.gd
extends HBoxContainer

const IconScene = preload("res://src/ui/ability_icon.tscn")
const FireIcon = preload("res://assets/sprites/ui/icons/Classes/Elementalist/Pyromancer/Pyromancer2.png")
const HealIcon = preload("res://assets/sprites/ui/icons/Classes/HolyDarkness/Priest/Priest8.png")
const SlowIcon = preload("res://assets/sprites/ui/icons/Classes/Elementalist/Cryomancer/Cryomancer4.png")

var icon_map = {}

func setup(abilities: Array) -> void:
    for child in get_children():
        child.queue_free()
    icon_map.clear()
    
    for ability in abilities:
        var icon = IconScene.instantiate()
        add_child(icon)
        
        var tex = FireIcon # Default
        if "Buff" in ability.name: tex = HealIcon
        elif "Debuff" in ability.name: tex = SlowIcon
        
        icon.setup(tex, ability.typing_pattern)
        icon_map[ability.name] = icon

func update_cooldowns(abilities: Array) -> void:
    for ability in abilities:
        if icon_map.has(ability.name):
            icon_map[ability.name].update_cooldown(ability.get_cooldown_remaining(), ability.cooldown_duration)
