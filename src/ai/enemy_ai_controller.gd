# enemy_ai_controller.gd
extends Node
class_name EnemyAIController

@export var attack_interval: float = 3.0 # No longer directly used for timing, but as a desired interval
@export var attack_ability: Ability # Will assign a DamageAbility here

var _parent_enemy: Enemy = null # Reference to the parent Enemy node
var _target: Character = null # Reference to the player

func _ready() -> void:
    print("EnemyAI: _ready called.")
    _parent_enemy = get_parent() as Enemy
    if not _parent_enemy:
        push_error("EnemyAIController must be a child of an Enemy node.")
        set_process(false)
        return
    
    # We will no longer use an internal Timer for casting.
    # The _process function will check ability readiness.

func set_target(target_character: Character) -> void:
    _target = target_character
    print("EnemyAI: Target set to %s." % _target.character_name)

# No _on_attack_timer_timeout needed anymore.
# No start_attack_timer needed anymore.

func _process(delta: float) -> void:
    if attack_ability:
        attack_ability._process_cooldown(delta) # Still process the ability's cooldown

        if _parent_enemy and _target and attack_ability._is_ready():
            print("EnemyAI: Ability ready, casting.")
            attack_ability._cast(_parent_enemy, _target)
        # else, if not ready, just wait for the next _process call
    else:
        if not attack_ability:
            print("Enemy AI: Attack ability not set (in _process).")