extends AbilityEffect
class_name BuffEffect

@export var buff: StatusEffect = null

func _apply(target: Character):
	target.apply_status_effect(buff.duplicate())