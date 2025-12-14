# enemy.gd
extends Character
class_name Enemy

@onready var health_bar: FloatingHealthBar = $FloatingHealthBar

func _ready() -> void:
	super._ready()
	character_name = "Enemy"
	if health_bar:
		health_bar.update_health(health, max_health)
		connect("health_changed", Callable(self, "_on_health_changed"))
		connect("status_effect_applied", Callable(self, "_on_status_applied"))
		connect("status_effect_removed", Callable(self, "_on_status_removed"))

func _on_health_changed(new_health: float) -> void:
	if health_bar:
		health_bar.update_health(new_health, max_health)

func _on_status_applied(effect: StatusEffect) -> void:
	if health_bar:
		var is_buff = effect.type == StatusEffect.StatusEffectType.BUFF
		health_bar.add_effect(effect.name, is_buff, effect.duration)

func _on_status_removed(effect_name: String) -> void:
	if health_bar:
		health_bar.remove_effect(effect_name)

func _physics_process(delta: float) -> void:
	# Enemy AI logic will go here.
	# For example, move towards the player.
	# For now, it's empty.
	pass