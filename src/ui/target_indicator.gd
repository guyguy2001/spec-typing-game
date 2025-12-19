# target_indicator.gd
extends Control # Extend Control instead of ColorRect for custom drawing
class_name TargetIndicator

@export var target_node: Node2D = null:
	set(value):
		target_node = value
		if target_node:
			show()
			_update_position()
			queue_redraw() # Request redraw if target changes
		else:
			hide()

var _color: Color = Color(1, 0, 0, 0.5) # Red, semi-transparent
var _radius: float = 32.0 # Half of the custom_minimum_size (64/2)

func _ready() -> void:
	if target_node:
		_update_position()
	else:
		hide()
	queue_redraw() # Initial draw

func _process(_delta: float) -> void:
	if target_node:
		_update_position()
	elif is_visible_in_tree():
		hide()

func _draw() -> void:
	if target_node:
		# Draw a filled circle at the center of this Control node
		draw_circle(Vector2(size.x / 2, size.y / 2), _radius, _color)

func _update_position() -> void:
	if target_node:
		var sprite_node: Sprite2D = target_node.get_node_or_null("Sprite2D")
		var offset_y = 0.0
		if sprite_node and sprite_node.texture:
			# Calculate half of the scaled sprite height
			offset_y = (sprite_node.texture.get_size().y * sprite_node.scale.y) / 2.0
		
		# Position the center of the indicator below the center of the target
		# global_position is top-left, so we offset by half of our own size
		# and add the character's sprite height to place it below the character
		global_position = target_node.global_position - (size / 2) + Vector2(0, offset_y)
	else:
		hide()