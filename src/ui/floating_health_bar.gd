# floating_health_bar.gd
extends ProgressBar
class_name FloatingHealthBar

const StatusIconScene = preload("res://src/ui/status_icon.tscn")

@onready var status_bar: HBoxContainer = $StatusBar

var active_icons: Dictionary = {}

func _ready() -> void:
	show_percentage = false

func update_health(new_health: float, max_health: float) -> void:
	max_value = max_health
	value = new_health

func add_effect(effect_name: String, icon_texture: Texture2D, duration: float) -> void:
	if active_icons.has(effect_name):
		# Update existing
		var icon = active_icons[effect_name]
		icon.setup(effect_name, icon_texture, duration)
		return

	var icon = StatusIconScene.instantiate()
	status_bar.add_child(icon)
	icon.setup(effect_name, icon_texture, duration)
	active_icons[effect_name] = icon

func remove_effect(effect_name: String) -> void:
	if active_icons.has(effect_name):
		var icon = active_icons[effect_name]
		icon.queue_free()
		active_icons.erase(effect_name)

func _process(delta: float) -> void:
	for icon in active_icons.values():
		# Visual tick down
		var new_val = icon.duration_overlay.value - delta
		icon.update_duration(new_val)
		if new_val <= 0:
			icon.modulate.a = 0.5 # Visual cue that it's expiring