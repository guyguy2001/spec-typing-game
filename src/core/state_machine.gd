# state_machine.gd
extends Node
class_name StateMachine

# Signal emitted when the state changes.
signal state_changed(new_state: String, old_state: String)

var _states: Dictionary = {}
var _current_state: Node = null
var _current_state_name: String = ""

# A "state" is just a Node with a few conventional methods.
# We add them as children to this StateMachine node.
func _ready() -> void:
	for child in get_children():
		if child.has_method("enter") and child.has_method("exit") and child.has_method("handle_input"):
			_states[child.name] = child
		else:
			push_warning("State '%s' is missing one or more required methods (enter, exit, handle_input)." % child.name)

# Sets the initial state. Called by the owner (e.g., the main game node).
func set_initial_state(state_name: String) -> void:
	if _states.has(state_name):
		_current_state = _states[state_name]
		_current_state_name = state_name
		_current_state.enter()
		emit_signal("state_changed", _current_state_name, "")
	else:
		push_error("Initial state '%s' not found in state machine." % state_name)

# Transitions to a new state.
func _transition_to(new_state_name: String) -> void:
	if not _states.has(new_state_name) or new_state_name == _current_state_name:
		return

	if _current_state:
		_current_state.exit()

	var old_state_name = _current_state_name
	_current_state = _states[new_state_name]
	_current_state_name = new_state_name
	
	_current_state.enter()
	emit_signal("state_changed", _current_state_name, old_state_name)

func _get_current_state() -> String:
	return _current_state_name

# Passes input events to the current state.
func _handle_input(event: InputEvent) -> void:
	if _current_state:
		_current_state.handle_input(event)

# Optional: Pass process and physics_process to the current state
func _process(delta: float) -> void:
	if _current_state and _current_state.has_method("process_update"):
		_current_state.process_update(delta)

func _physics_process(delta: float) -> void:
	if _current_state and _current_state.has_method("physics_update"):
		_current_state.physics_update(delta)
