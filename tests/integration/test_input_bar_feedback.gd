extends GutTest

var arena_scene = preload("res://src/core/arena.tscn")
var arena_instance: Node2D

func before_each():
	# Instantiate arena and add to scene
	arena_instance = arena_scene.instantiate()
	get_tree().get_root().add_child(arena_instance)
	
	# Wait for _ready to complete
	await get_tree().process_frame
	
	# Access HUD and InputBuffer
	gut.p("Arena instance: %s" % arena_instance)
	gut.p("HUD node: %s" % arena_instance.get_node("HUD"))
	gut.p("InputFeedbackBar: %s" % arena_instance.get_node("HUD").input_feedback_bar)
	gut.p("InputBuffer: %s" % arena_instance.input_buffer)
	
	assert_not_null(arena_instance.get_node("HUD"), "HUD should be present in Arena")
	assert_not_null(arena_instance.get_node("HUD").input_feedback_bar, "InputFeedbackBar should be present in HUD")
	assert_not_null(arena_instance.input_buffer, "InputBuffer should be present in Arena")

func after_each():
	arena_instance.queue_free()
	arena_instance = null

func test_input_bar_updates_on_typing():
	var input_feedback_bar: Label = arena_instance.get_node("HUD").input_feedback_bar
	var input_handler: InputHandler = arena_instance.input_handler

	assert_eq(input_feedback_bar.text, "", "Input bar should start empty")

	# Simulate typing 'a'
	input_handler.emit_signal("text_input", "a")
	await get_tree().process_frame
	assert_eq(input_feedback_bar.text, "a", "Input bar should display 'a'")

	# Simulate typing 'b'
	input_handler.emit_signal("text_input", "b")
	await get_tree().process_frame
	assert_eq(input_feedback_bar.text, "ab", "Input bar should display 'ab'")

	# Simulate backspace
	input_handler.emit_signal("backspace_pressed")
	await get_tree().process_frame
	assert_eq(input_feedback_bar.text, "a", "Input bar should display 'a' after backspace")
	
	# Simulate clear
	arena_instance.input_buffer.clear()
	await get_tree().process_frame
	assert_eq(input_feedback_bar.text, "", "Input bar should be empty after clear")
