# game_over.gd
extends Control
class_name GameOverUI

@onready var restart_button: Button = $Panel/VBoxContainer/RestartButton

func _ready() -> void:
    restart_button.pressed.connect(Callable(self, "restart_game"))
    # Hide the UI initially, Arena will show it

func restart_game() -> void:
    get_tree().reload_current_scene()
