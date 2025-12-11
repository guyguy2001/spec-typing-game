# i_character.gd (Interface concept)
# This file serves as a documentation for the expected interface of a Character (Player or Enemy) class.

class_name ICharacter

# Call to deal damage to this character.
# Parameters:
#   amount: float - The amount of damage to deal.
# Returns: void
static func _take_damage(amount: float) -> void:
    push_error("ICharacter._take_damage() not implemented. This is an interface concept.")

# Call to apply a status effect to this character.
# Parameters:
#   effect: StatusEffect - The status effect to apply.
# Returns: void
static func _apply_status_effect(effect: StatusEffect) -> void:
    push_error("ICharacter._apply_status_effect() not implemented. This is an interface concept.")

# Call to remove a status effect from this character.
# Parameters:
#   effect_name: String - The name of the status effect to remove.
# Returns: void
static func _remove_status_effect(effect_name: String) -> void:
    push_error("ICharacter._remove_status_effect() not implemented. This is an interface concept.")

# Call to get the character's current health.
# Returns: float - Current health.
static func _get_health() -> float:
    push_error("ICharacter._get_health() not implemented. This is an interface concept.")

# Expected signals (if applicable):
#   "health_changed(new_health: float)"
#   "died()"
#   "status_effect_applied(effect_name: String)"
#   "status_effect_removed(effect_name: String)"

# Expected properties (read-only for external access):
#   name: String
#   health: float
#   max_health: float
#   active_status_effects: Array[StatusEffect]
