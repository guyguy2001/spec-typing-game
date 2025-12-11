# i_game_state_machine.gd (Interface concept)
# This file serves as a documentation for the expected interface of the Game State Machine.

class_name IGameStateMachine

# Call to transition to a new game state.
# Parameters:
#   new_state: String - The name of the state to transition to (e.g., "Combat", "Menu", "GameOver").
# Returns: void
static func _transition_to(new_state: String) -> void:
    push_error("IGameStateMachine._transition_to() not implemented. This is an interface concept.")

# Call to get the current game state.
# Returns: String - The name of the current active state.
static func _get_current_state() -> String:
    push_error("IGameStateMachine._get_current_state() not implemented. This is an interface concept.")

# Call to handle input events, delegating to the current active state.
# Parameters:
#   event: InputEvent - The input event to process.
# Returns: void
static func _handle_input(event: InputEvent) -> void:
    push_error("IGameStateMachine._handle_input() not implemented. This is an interface concept.")

# Expected signals (if applicable):
#   "state_changed(new_state: String, old_state: String)"

# Expected properties (read-only for external access):
#   current_state: String
