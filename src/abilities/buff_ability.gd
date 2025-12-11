# buff_ability.gd
extends Ability
class_name BuffAbility

@export var buff_duration: float = 5.0
@export var stat_to_buff: StatusEffect.ModifierType = StatusEffect.ModifierType.GENERIC_EFFECT_VALUE

func _init() -> void:
    name = "Buff Ability"
    typing_pattern = "heal" # Placeholder
    effect_type = EffectType.BUFF
    effect_value = 10.0
    cooldown_duration = 8.0
    description = "A basic buff ability."

func _cast(caster: Node, target: Node) -> void:
    if not _is_ready():
        print("Buff Ability %s on cooldown." % name)
        return

    # Buffs usually apply to self, but could target friends.
    # For this User Story, "cast a buff on themselves".
    var apply_target = caster
    
    print("%s casts %s on %s." % [caster.character_name, name, apply_target.character_name])
    
    # Create the effect
    var effect = StatusEffect.new()
    effect.name = name # Use ability name as effect name
    effect.type = StatusEffect.StatusEffectType.BUFF
    effect.duration = buff_duration
    effect.modifier_type = stat_to_buff
    effect.modifier_value = effect_value
    
    if apply_target.has_method("_apply_status_effect"):
        apply_target._apply_status_effect(effect)
    
    _start_cooldown()
