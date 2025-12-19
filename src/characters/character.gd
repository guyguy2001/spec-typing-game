# character.gd
extends CharacterBody2D
class_name Character

@export var character_name: String = "Unnamed Character"
@export var max_health: float = 100.0
@export var speed: float = 100.0

var health: float = max_health
var active_status_effects: Array[StatusEffect] = []

signal health_changed(max_health: float, new_health: float)
signal damage_taken(amount: float)
signal died()
signal status_effect_applied(effect: StatusEffect)
signal status_effect_removed(effect_name: StatusEffect)


func _ready() -> void:
	health = max_health

# Interface methods from ICharacter
func take_damage(amount: float) -> void:
	health = max(0, health - amount)
	emit_signal("health_changed", max_health, health)
	emit_signal("damage_taken", amount)
	if health <= 0:
		emit_signal("died")
		queue_free() # Placeholder for character death

func apply_status_effect(effect: StatusEffect) -> void:
	# Check if effect already exists and handle stacking/refreshing
	for i in range(active_status_effects.size()):
		if active_status_effects[i].name == effect.name:
			# Refresh duration if already exists, or stack
			active_status_effects[i].time_remaining = effect.duration
			return
	
	active_status_effects.append(effect)
	print("%s applied status effect: %s" % [character_name, effect.name])
	emit_signal("status_effect_applied", effect)

func remove_status_effect(effect: StatusEffect) -> void:
	var index_to_remove = -1
	for i in range(active_status_effects.size()):
		if active_status_effects[i] == effect:
			index_to_remove = i
			break
	
	if index_to_remove != -1:
		active_status_effects.remove_at(index_to_remove)
		emit_signal("status_effect_removed", effect)

func get_health() -> float:
	return health

func _process(delta: float) -> void:
	_process_status_effects(delta)

func _physics_process(_delta: float) -> void:
	pass # To be implemented by subclasses (Player/Enemy)

func _process_status_effects(delta: float) -> void:
	var effects_to_remove: Array = []
	for effect in active_status_effects:
		var tick_value = effect.tick(delta)
		
		if tick_value != 0:
			# Handle periodic effects
			if effect.type == StatusEffect.StatusEffectType.BUFF:
				# Heal
				health = min(health + tick_value, max_health)
				emit_signal("health_changed", health)
			else:
				# Damage (Poison)
				take_damage(tick_value)
		
		if not effect.is_active():
			effects_to_remove.append(effect)
	
	for effect in effects_to_remove:
		remove_status_effect(effect)
