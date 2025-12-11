# damage_ability.gd
extends Ability
class_name DamageAbility

func _init() -> void:
    name = "Damage Ability"
    typing_pattern = "fire" # Placeholder
    effect_type = EffectType.DAMAGE
    effect_value = 25.0
    cooldown_duration = 2.0
    description = "A basic damage-dealing ability."

func _cast(caster: Node, target: Node) -> void:
    if not _is_ready():
        print("Damage Ability %s on cooldown." % name)
        return

    print("%s casts %s on %s for %s damage." % [caster.character_name, name, target.character_name, effect_value])
    if target and target.has_method("_take_damage"):
        target._take_damage(effect_value)
    
    _start_cooldown()
