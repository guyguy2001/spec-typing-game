extends AbilityEffect
class_name DamageEffect

@export var damage: float = 5.0

func _apply(target: Character):
	target.take_damage(damage)