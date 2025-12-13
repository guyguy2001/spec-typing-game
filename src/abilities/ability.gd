# ability.gd
extends Resource
class_name Ability

# Represents the type of effect an ability has.
enum EffectType {DAMAGE, BUFF, DEBUFF}

@export var name: String = ""
@export var typing_pattern: String = ""
@export var effect_type: EffectType = EffectType.DAMAGE
@export var effect_value: float = 0.0
@export var cooldown_duration: float = 0.0
@export var description: String = ""

var _current_cooldown: float = 0.0

# Signals (for demonstration, as Resources don't emit signals directly to the scene tree easily)
# For actual signal implementation in Godot, these would likely be emitted by a Node handling abilities.
signal ability_cast_success(ability_name: String)
signal ability_cast_failed(ability_name: String, reason: String)
signal cooldown_started(ability_name: String, duration: float)
signal cooldown_updated(ability_name: String, remaining: float)


func _init() -> void:
    pass

# Interface methods from IAbility (adapted for a Resource)
func cast(caster: Node, target: Node) -> void:
    if not is_ready():
        #emit_signal("ability_cast_failed", name, "On Cooldown")
        print("Ability %s on cooldown." % name)
        return

    print("Casting %s from %s to %s" % [name, caster.name, target.name])
    # Placeholder for actual effect logic
    match effect_type:
        EffectType.DAMAGE:
            if target and target.has_method("take_damage"):
                target.take_damage(effect_value)
        EffectType.BUFF, EffectType.DEBUFF:
            # Requires StatusEffect implementation
            print("Applying %s effect (requires StatusEffect implementation)" % effect_type)

    start_cooldown()
    #emit_signal("ability_cast_success", name)

func get_cooldown_remaining() -> float:
    return _current_cooldown

func is_ready() -> bool:
    return _current_cooldown <= 0.0

func get_typing_pattern() -> String:
    return typing_pattern

func start_cooldown() -> void:
    _current_cooldown = cooldown_duration
    #emit_signal("cooldown_started", name, cooldown_duration)

func process_cooldown(delta: float) -> void:
    if _current_cooldown > 0:
        _current_cooldown -= delta
        if _current_cooldown < 0:
            _current_cooldown = 0
        #emit_signal("cooldown_updated", name, _current_cooldown)
