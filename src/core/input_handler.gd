# input_handler.gd
extends Node
class_name InputHandler

signal text_input(char: String)
signal key_pressed(keycode: int)
signal backspace_pressed()
signal space_pressed()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			# Handle specific key presses
			if event.keycode == KEY_BACKSPACE:
				emit_signal("backspace_pressed")
			elif event.keycode == KEY_SPACE:
				emit_signal("space_pressed")
			elif event.unicode >= 33: # Standard printable characters start at 33 (!), Space is 32
				emit_signal("text_input", char(event.unicode))
			
			emit_signal("key_pressed", event.keycode)
			get_viewport().set_input_as_handled() # Mark input as handled to prevent further processing
