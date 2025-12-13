# enemy_attack.gd
extends DamageAbility # Extends DamageAbility for enemy-specific damage
class_name EnemyAttackAbility

func _init() -> void:
    name = "Enemy Attack"
    typing_pattern = "" # No typing pattern for AI
    effect_type = EffectType.DAMAGE
    effect_value = 10.0 # Base damage for enemy
    cooldown_duration = 3.0
    description = "A basic enemy attack."