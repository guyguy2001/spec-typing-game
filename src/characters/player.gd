# player.gd
extends Character
class_name Player

# Player-specific properties can be added here.
# For example, an array to hold the player's ability resources.
@export var abilities: Array[Ability] = []

var current_typing_input: String = ""

func _ready() -> void:
	# You can call the parent's ready function if it has one.
	super._ready()
	character_name = "Player"

func _physics_process(delta: float) -> void:
	# Player movement logic will go here.
	# For now, it's empty.
	pass

func handle_input(event: InputEvent) -> void:
    # Logic to handle player's typing input will go here.
    # This will be built out in User Story 1 (T013).
    pass
