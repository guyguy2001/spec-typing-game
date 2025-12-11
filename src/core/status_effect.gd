# status_effect.gd
extends Resource
class_name StatusEffect

# Represents the type of status effect (beneficial or detrimental).
enum StatusEffectType { BUFF, DEBUFF }

# Represents the type of attribute modified by the status effect.
enum ModifierType { DAMAGE, SPEED, DEFENSE, GENERIC_EFFECT_VALUE } # Added GENERIC_EFFECT_VALUE for flexibility

@export var name: String = ""
@export var type: StatusEffectType = StatusEffectType.BUFF
@export var duration: float = 0.0 # 0.0 for permanent until removed
@export var modifier_type: ModifierType = ModifierType.GENERIC_EFFECT_VALUE
@export var modifier_value: float = 0.0

var time_remaining: float = 0.0

func _init() -> void:
    time_remaining = duration

func _process(delta: float) -> void:
    if duration > 0: # Only tick down if not permanent
        time_remaining -= delta
        if time_remaining < 0:
            time_remaining = 0

func is_active() -> bool:
    return time_remaining > 0 or duration == 0
