# player.gd
extends Character
class_name Player

# Player-specific properties can be added here.
# For example, an array to hold the player's ability resources.
@export var abilities: Array[Ability] = []

var current_typing_input: String = ""
var target_enemy: Character = null # Will be set by the arena scene

func _ready() -> void:
	# You can call the parent's ready function if it has one.
	super._ready()
	character_name = "Player"
	
	if abilities.is_empty():
		var fire_ability = DamageAbility.new()
		abilities.append(fire_ability)
		
		var heal_ability = BuffAbility.new()
		abilities.append(heal_ability)
		
		var slow_ability = DebuffAbility.new()
		abilities.append(slow_ability)
		
		print("Added default Fire, Heal, and Slow abilities to Player.")

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
		if ability._get_typing_pattern().to_lower() == current_typing_input.to_lower():
			if ability._is_ready():
				if target_enemy:
					ability._cast(self, target_enemy) # Pass self as caster, target_enemy as target
					cast_successful = true
					break
				else:
					print("No target for ability %s." % ability.name)
			else:
				print("Ability %s is on cooldown." % ability.name)
	
	if not cast_successful:
		print("No matching ability or target found for '%s'." % current_typing_input)
		print("Abilities: %s" % abilities.map(func(a): a._get_typing_pattern().to_lower()))
	current_typing_input = "" # Always reset input after space or attempted cast

func _process_ability_cooldowns(delta: float) -> void:
	for ability in abilities:
		ability._process_cooldown(delta)
