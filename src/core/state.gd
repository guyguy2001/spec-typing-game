# state.gd
extends Node
class_name State

# Called when entering the state.
func enter() -> void:
	pass

# Called when exiting the state.
func exit() -> void:
	pass

# Called to handle input events.
func handle_input(event: InputEvent) -> void:
	pass

# Optional: Called every frame.
func process_update(delta: float) -> void:
	pass

# Optional: Called every physics frame.
func physics_update(delta: float) -> void:
	pass
