# status_effect.gd
extends Resource
class_name StatusEffect

# Represents the type of status effect (beneficial or detrimental).
enum StatusEffectType { BUFF, DEBUFF }

# Represents the type of attribute modified by the status effect.
enum ModifierType { DAMAGE, SPEED, DEFENSE, GENERIC_EFFECT_VALUE }

@export var name: String = ""
@export var type: StatusEffectType = StatusEffectType.BUFF

# Use a setter to ensure time_remaining is always synced with duration upon initialization
@export var duration: float = 0.0:
	set(value):
		duration = value
		# Only sync if time_remaining hasn't been ticked down yet (or is 0)
		# This allows resetting duration by just setting 'duration' again.
		time_remaining = value

@export var modifier_type: ModifierType = ModifierType.GENERIC_EFFECT_VALUE
@export var modifier_value: float = 0.0

var time_remaining: float = 0.0

func _init(p_duration: float = 0.0) -> void:
	duration = p_duration
	time_remaining = p_duration

func tick(delta: float) -> void:
	if duration > 0: # Only tick down if not permanent
		time_remaining -= delta
		if time_remaining < 0:
			time_remaining = 0

func is_active() -> bool:
	return time_remaining > 0 or duration == 0