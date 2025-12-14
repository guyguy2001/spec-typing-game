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

class PreCastingData:
	var caster: Character
	var target: WeakRef # Ref to a Character

	func _init(_caster: Character, _target: WeakRef) -> void:
		self.caster = _caster
		self.target = _target

var current_cooldown: float = 0.0
var pre_casting: PreCastingData = null

func _init() -> void:
	pass

# Interface methods from IAbility (adapted for a Resource)
func cast(caster: Character, target: Character) -> void:
	if target_type == Target.ENEMY_TARGET and not target:
		# Should this be in _cast?
		# The reason it's here is that I don't want to pre-cast problematically
		# Design TODO: Should pre-cast be to the enemy I targeted when typing,
		# or the one that's targeted when the ability is proc'ed?
		return

	if not is_ready():
		if pre_casting != null:
			print("Already pre casting %s" % pre_casting)
		else:
			pre_casting = PreCastingData.new(caster, weakref(target))
		return
	
	self._cast(caster, target)


func _cast(caster: Character, target: Character):
	print("Casting %s from %s to %s" % [name, caster.name, target.name])
	match target_type:
		Target.ENEMY_TARGET:
			effect.apply(target)
		Target.SELF:
			effect.apply(caster)

	start_cooldown()

func is_ready() -> bool:
	return current_cooldown <= 0.0

func get_typing_pattern() -> String:
	return typing_pattern

func start_cooldown() -> void:
	current_cooldown = cooldown_duration
	pre_casting = null

func process_cooldown(delta: float) -> void:
	if current_cooldown > 0:
		current_cooldown -= delta
		if current_cooldown <= 0:
			if pre_casting:
				var target: Character = pre_casting.target.get_ref()
				if target:
					_cast(pre_casting.caster, target)
				else:
					pre_casting = null
			else:
				current_cooldown = 0
