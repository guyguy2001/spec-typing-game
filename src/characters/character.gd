# character.gd
extends CharacterBody2D
class_name Character

@export var character_name: String = "Unnamed Character"
@export var max_health: float = 100.0
@export var speed: float = 100.0

var health: float = max_health
var active_status_effects: Array[StatusEffect] = []

signal health_changed(new_health: float)
signal died()
signal status_effect_applied(effect_name: String)
signal status_effect_removed(effect_name: String)


func _ready() -> void:
    health = max_health

# Interface methods from ICharacter
func _take_damage(amount: float) -> void:
    health = maxi(0, health - amount)
    emit_signal("health_changed", health)
    if health <= 0:
        emit_signal("died")
        queue_free() # Placeholder for character death

func _apply_status_effect(effect: StatusEffect) -> void:
    # Check if effect already exists and handle stacking/refreshing
    for i in range(active_status_effects.size()):
        if active_status_effects[i].name == effect.name:
            # Refresh duration if already exists, or stack
            active_status_effects[i].time_remaining = effect.duration
            return
    
    active_status_effects.append(effect)
    emit_signal("status_effect_applied", effect.name)

func _remove_status_effect(effect_name: String) -> void:
    var index_to_remove = -1
    for i in range(active_status_effects.size()):
        if active_status_effects[i].name == effect_name:
            index_to_remove = i
            break
    
    if index_to_remove != -1:
        active_status_effects.remove_at(index_to_remove)
        emit_signal("status_effect_removed", effect_name)

func _get_health() -> float:
    return health

func _process(delta: float) -> void:
    _process_status_effects(delta)

func _physics_process(delta: float) -> void:
    pass # To be implemented by subclasses (Player/Enemy)

func _process_status_effects(delta: float) -> void:
    var effects_to_remove: Array = []
    for effect in active_status_effects:
        effect._process(delta) # Let the effect tick down its own timer
        if not effect.is_active():
            effects_to_remove.append(effect.name)
    
    for effect_name in effects_to_remove:
        _remove_status_effect(effect_name)
