# player.gd
extends Character
class_name Player

# Player-specific properties can be added here.
# For example, an array to hold the player's ability resources.
@export var abilities: Array[Ability] = []

var current_typing_input: String = ""
var target_enemy: Character = null: # Will be set by the arena scene
	set(value):
		target_enemy = value
		target_changed.emit(value)

signal target_changed(target: Character)
signal abilities_setup(abilities: Array)
signal abilities_updated(abilities: Array)

func _ready() -> void:
	# You can call the parent's ready function if it has one.
	super._ready()
	character_name = "Player"
	
	# if abilities.is_empty():
	# 	abilities.append(load("res://resources/fire_ability.tres"))
	# 	abilities.append(load("res://resources/heal_ability.tres"))
	# 	abilities.append(load("res://resources/poison_ability.tres"))
		
	# 	print("Added default Fire, Heal, and Poison abilities to Player from resources.")
	
	# Defer signal emission to ensure HUD is ready
	call_deferred("emit_signal", "abilities_setup", abilities)

func _physics_process(delta: float) -> void:
	super._physics_process(delta) # Call parent's physics_process for status effects
	_process_ability_cooldowns(delta) # Process cooldowns for player's abilities

func handle_input(event: InputEvent) -> void:
	# Logic to handle player's typing input will go here.
	# This will be built out in User Story 1 (T013).
	pass

func _on_input_handler_text_input(char: String) -> void:
	current_typing_input += char
	print("Player typing: ", current_typing_input) # For debugging

func _on_input_handler_backspace_pressed() -> void:
	if current_typing_input.length() > 0:
		current_typing_input = current_typing_input.substr(0, current_typing_input.length() - 1)
		print("Player typing: ", current_typing_input) # For debugging

func _on_input_handler_space_pressed() -> void:
	print("Space pressed, current input: ", current_typing_input)
	
	var cast_successful = false
	for ability in abilities:
		if ability.get_typing_pattern().to_lower() == current_typing_input.to_lower():
			ability.cast(self, target_enemy) # Pass self as caster, target_enemy as target
			cast_successful = true
			break
	
	current_typing_input = "" # Always reset input after space or attempted cast
	if not cast_successful:
		print("No matching ability or target found for '%s'." % current_typing_input)

func _process_ability_cooldowns(delta: float) -> void:
	for ability in abilities:
		ability.process_cooldown(delta)
