# i_ability.gd (Interface concept)
# This file serves as a documentation for the expected interface of an Ability class.
# In GDScript, interfaces are typically implemented using duck typing or by inheriting
# from a base class that provides default implementations or empty methods.

# Expected methods for any Ability class:
class_name IAbility

# Call to execute the ability's effect.
# Parameters:
#   caster: Node - The character casting the ability.
#   target: Node - The target of the ability (e.g., enemy, self).
# Returns: void
static func _cast(caster: Node, target: Node) -> void:
    push_error("IAbility._cast() not implemented. This is an interface concept.")

# Call to get the current cooldown status.
# Returns: float - Time remaining on cooldown.
static func _get_cooldown_remaining() -> float:
    push_error("IAbility._get_cooldown_remaining() not implemented. This is an interface concept.")

# Call to check if the ability is ready to be cast.
# Returns: bool - True if ready, false otherwise.
static func _is_ready() -> bool:
    push_error("IAbility._is_ready() not implemented. This is an interface concept.")

# Call to get the typing pattern required for the ability.
# Returns: String - The typing sequence (e.g., "fireball", "a").
static func _get_typing_pattern() -> String:
    push_error("IAbility._get_typing_pattern() not implemented. This is an interface concept.")

# Expected signals (if applicable):
#   "ability_cast_success(ability_name: String)"
#   "ability_cast_failed(ability_name: String, reason: String)"
#   "cooldown_started(ability_name: String, duration: float)"
#   "cooldown_updated(ability_name: String, remaining: float)"

# Expected properties (read-only for external access):
#   name: String
#   effect_type: String (e.g., "damage", "buff", "debuff")
#   cooldown_duration: float
#   description: String
