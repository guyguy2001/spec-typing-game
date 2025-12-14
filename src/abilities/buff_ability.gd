# buff_ability.gd
extends Ability
class_name BuffAbility

@export var buff_duration: float = 5.0

func cast(caster: Node, target: Node) -> void:
	print("BuffAbility: Cast method called. Caster: %s, Target: %s" % [caster.name, target.name])
	if not is_ready():
		print("Buff Ability %s on cooldown." % name)
		return

	var apply_target = caster
	
	print("%s casts %s on %s." % [caster.character_name, name, apply_target.character_name])
	
	# Create the effect
	var effect = StatusEffect.new()
	effect.name = name
	effect.icon = icon
	effect.type = StatusEffect.StatusEffectType.BUFF
	effect.duration = buff_duration
	effect.modifier_type = StatusEffect.ModifierType.HEALTH_CHANGE
	effect.modifier_value = effect_value
	effect.tick_interval = 1.0
	
	if apply_target.has_method("apply_status_effect"):
		apply_target.apply_status_effect(effect)
	
	start_cooldown()
