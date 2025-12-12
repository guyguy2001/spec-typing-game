# enemy_attack.gd
extends DamageAbility
class_name EnemyAttackAbility

func _init() -> void:
    name = "Enemy Attack"
    typing_pattern = "" # No typing for enemy abilities
    effect_type = EffectType.DAMAGE
    effect_value = 10.0 # Base damage for enemy
    cooldown_duration = 3.0
    description = "A basic attack from an enemy."

func _cast(caster: Node, target: Node) -> void:
    if not _is_ready():
        print("%s's attack on cooldown." % caster.character_name)
        return

    print("%s attacks %s for %s damage." % [caster.character_name, target.character_name, effect_value])
    if target and target.has_method("_take_damage"):
        target._take_damage(effect_value)
    
    _start_cooldown()
