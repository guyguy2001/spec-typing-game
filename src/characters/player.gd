# player.gd
extends Character
class_name Player

# Player-specific properties can be added here.
# For example, an array to hold the player's ability resources.
@export var abilities: Array[Ability] = []
@export var input_buffer: InputBuffer

var target_enemy: Character = null: # Will be set by the arena scene
	set(value):
		target_enemy = value
		target_changed.emit(value)

signal target_changed(target: Character)
@warning_ignore("UNUSED_SIGNAL") # I still wanted to wire the UI to it
signal abilities_changed(abilities: Array)

func _ready() -> void:
	# You can call the parent's ready function if it has one.
	super._ready()
	character_name = "Player"
	input_buffer.word_submitted.connect(_cast_spell)

func _physics_process(delta: float) -> void:
	super._physics_process(delta) # Call parent's physics_process for status effects
	_process_ability_cooldowns(delta) # Process cooldowns for player's abilities

func _cast_spell(text) -> void:
	var cast_successful = false
	for ability in abilities:
		if ability.get_typing_pattern().to_lower() == text.to_lower():
			ability.cast(self, target_enemy) # Pass self as caster, target_enemy as target
			cast_successful = true
			break
	
	if not cast_successful:
		print("No matching ability or target found for '%s'." % text)

func _process_ability_cooldowns(delta: float) -> void:
	for ability in abilities:
		ability.process_cooldown(delta)
