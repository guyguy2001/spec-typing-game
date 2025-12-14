# debuff_ability.gd
extends Ability
class_name DebuffAbility

@export var debuff_duration: float = 10.0

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
	effect.icon = icon
	effect.type = StatusEffect.StatusEffectType.DEBUFF
	effect.duration = debuff_duration
	effect.modifier_type = StatusEffect.ModifierType.HEALTH_CHANGE
	effect.modifier_value = effect_value
	effect.tick_interval = 1.0
	
	if target and target.has_method("apply_status_effect"):
		target.apply_status_effect(effect)
	
	start_cooldown()
