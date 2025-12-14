class_name TypableLabel
extends RichTextLabel

@export var target_text: String = "":
	set(value):
		target_text = value
		update_text_display(last_input)

@export var active_color: Color = Color.RED
@export var default_color: Color = Color.WHITE

var last_input: String = ""

func _ready() -> void:
	# Ensure RichTextLabel is set to process BBCode
	set_use_bbcode(true)
	update_text_display("") # Initial display

func on_input_changed(current_input: String) -> void:
	last_input = current_input
	update_text_display(current_input)

func update_text_display(current_input: String) -> void:
	if target_text.is_empty():
		self.text = ""
		return

	var bbcode_text: String
	var is_prefix_match = true
	
	if current_input.length() > target_text.length():
		is_prefix_match = false
	else:
		for i in range(current_input.length()):
			if current_input[i] != target_text[i]:
				is_prefix_match = false
				break

	if current_input.is_empty(): # Handle empty input separately, as per previous logic
		bbcode_text = "[color=#%s]%s[/color]" % [default_color.to_html(false).to_upper(), target_text]
	elif is_prefix_match: # This replaces the 'begins_with' check
		var matched_part = target_text.substr(0, current_input.length())
		var remaining_part = target_text.substr(current_input.length())
		bbcode_text = "[color=#%s]%s[/color][color=#%s]%s[/color]" % [
			active_color.to_html(false).to_upper(), matched_part,
			default_color.to_html(false).to_upper(), remaining_part
		]
	else:
		# If input does not match prefix, display full target text in default color
		bbcode_text = "[color=#%s]%s[/color]" % [default_color.to_html(false).to_upper(), target_text]
	
	self.text = bbcode_text
