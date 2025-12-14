# ability.gd
extends Resource
class_name Ability

# Represents the type of effect an ability has.
enum Target {ENEMY_TARGET, SELF}
	
@export var name: String = ""
@export var icon: Texture2D
@export var typing_pattern: String = ""
@export var effect: AbilityEffect = null
@export var target_type := Target.ENEMY_TARGET
@export var cooldown_duration: float = 3.0
@export var description: String = ""

var _current_cooldown: float = 0.0

func _init() -> void:
	pass

# Interface methods from IAbility (adapted for a Resource)
func cast(caster: Node, target: Node) -> void:
	if not is_ready():
		print("Ability %s on cooldown." % name)
		return

	print("Casting %s from %s to %s" % [name, caster.name, target.name])
	# Placeholder for actual effect logic
	match target_type:
		Target.ENEMY_TARGET:
			effect.apply(target)
		Target.SELF:
			effect.apply(caster)

	start_cooldown()

func get_cooldown_remaining() -> float:
	return _current_cooldown

func is_ready() -> bool:
	return _current_cooldown <= 0.0

func get_typing_pattern() -> String:
	return typing_pattern

func start_cooldown() -> void:
	_current_cooldown = cooldown_duration

func process_cooldown(delta: float) -> void:
	if _current_cooldown > 0:
		_current_cooldown -= delta
		if _current_cooldown < 0:
			_current_cooldown = 0
