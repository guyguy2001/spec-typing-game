# target_indicator.gd
extends ColorRect
class_name TargetIndicator

@export var target_node: Node2D = null:
	set(value):
		target_node = value
		if target_node:
			show()
			global_position = target_node.global_position - (size / 2)
		else:
			hide()

func _ready() -> void:
	if target_node:
		show()
		global_position = target_node.global_position - (size / 2)
	else:
		hide()

func _process(delta: float) -> void:
	if target_node:
		global_position = target_node.global_position - (size / 2)
	elif is_visible_in_tree():
		hide()