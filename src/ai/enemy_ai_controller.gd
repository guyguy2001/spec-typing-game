# enemy_ai_controller.gd
extends Node
class_name EnemyAIController

@export var attack_interval: float = 3.0
@export var attack_ability: Ability # Will assign a DamageAbility here

@onready var timer: Timer = $Timer # Timer node is expected as a child named "Timer"

var _parent_enemy: Enemy = null # Reference to the parent Enemy node
var _target: Character = null # Reference to the player

func _ready() -> void:
	_parent_enemy = get_parent() as Enemy
	if not _parent_enemy:
		push_error("EnemyAIController must be a child of an Enemy node.")
		set_process_mode(Node.PROCESS_MODE_DISABLED) # Disable processing if not attached correctly
		return
	
	# Timer properties are expected to be set in the editor (tscn)
	# Connect signal in code as per convention
	if timer:
		timer.connect("timeout", _on_attack_timer_timeout)
	else:
		push_error("EnemyAIController: Child Timer node not found! Please add a Timer node named 'Timer' in the scene.")
		set_process_mode(Node.PROCESS_MODE_DISABLED) # Disable processing if no timer


func set_target(target_character: Character) -> void:
	_target = target_character
	print("EnemyAI: Target set to %s." % _target.character_name)

func start_attack_timer() -> void:
	if timer:
		timer.start()
		print("EnemyAI: Attack timer started.")
	else:
		push_error("EnemyAI: Timer not initialized!") # This should now be caught in _ready if Timer node is missing

func _on_attack_timer_timeout() -> void:
	if _parent_enemy and _target and attack_ability:
		if attack_ability.is_ready():
			attack_ability.cast(_parent_enemy, _target)
		else:
			print("Enemy AI: Ability %s on cooldown (should not happen if logic is correct)." % attack_ability.name)
	else:
		# For debugging purposes
		if not _parent_enemy:
			print("Enemy AI: Parent enemy not set.")
		if not _target:
			print("Enemy AI: Target not set.")
		if not attack_ability:
			print("Enemy AI: Attack ability not set.")

func _process(delta: float) -> void:
	if attack_ability:
		attack_ability.process_cooldown(delta) # Still process the ability's cooldown