# damage_ability.gd
extends Ability
class_name DamageAbility

func cast(caster: Node, target: Node) -> void:
	if not is_ready():
		print("Damage Ability %s on cooldown." % name)
		return

	print("%s casts %s on %s for %s damage." % [caster.character_name, name, target.character_name, effect_value])
	if target and target.has_method("take_damage"):
		target.take_damage(effect_value)
	
	start_cooldown()