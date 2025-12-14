extends Label

func _ready() -> void:
	self.text = "" # Initialize with empty text

func on_input_changed(new_text: String) -> void:
	self.text = new_text
