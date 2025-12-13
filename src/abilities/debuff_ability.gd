# debuff_ability.gd
extends Ability
class_name DebuffAbility

@export var debuff_duration: float = 5.0
@export var stat_to_debuff: StatusEffect.ModifierType = StatusEffect.ModifierType.GENERIC_EFFECT_VALUE

func _init() -> void:
	name = "Debuff Ability"
	typing_pattern = "slow" # Placeholder
	effect_type = EffectType.DEBUFF
	effect_value = 10.0
	cooldown_duration = 10.0
	description = "A basic debuff ability."

func cast(caster: Node, target: Node) -> void:
	print("DebuffAbility: Cast method called. Caster: %s, Target: %s" % [caster.name, target.name])
	if not is_ready():
		print("Debuff Ability %s on cooldown." % name)
		return

	# Debuffs apply to the target.
	print("%s casts %s on %s." % [caster.character_name, name, target.character_name])
	
	# Create the effect
	var effect = StatusEffect.new()
	effect.name = name
	effect.type = StatusEffect.StatusEffectType.DEBUFF
	effect.duration = debuff_duration
	effect.modifier_type = stat_to_debuff
	effect.modifier_value = effect_value
	
	if target and target.has_method("apply_status_effect"):
		target.apply_status_effect(effect)
	
	start_cooldown()
