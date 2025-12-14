class_name InputBuffer
extends Node

# Emitted whenever the text in the buffer changes (typing, backspace, clear)
signal input_changed(new_text: String)

# Emitted when the buffer is cleared explicitly (e.g. after a successful cast)
signal input_cleared()

var current_text: String = ""
var max_length: int = 50 # Prevent infinite strings

func _ready() -> void:
	pass

func handle_text_input(char_str: String) -> void:
	if current_text.length() >= max_length:
		return
	
	current_text += char_str
	emit_signal("input_changed", current_text)

func handle_backspace() -> void:
	if current_text.length() > 0:
		current_text = current_text.left(current_text.length() - 1)
		emit_signal("input_changed", current_text)

func clear() -> void:
	current_text = ""
	emit_signal("input_changed", current_text)
	emit_signal("input_cleared")

func get_text() -> String:
	return current_text
