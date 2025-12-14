extends GutTest

var input_buffer: InputBuffer

func before_each():
	input_buffer = InputBuffer.new()
	add_child_autofree(input_buffer)

func test_initial_state():
	assert_eq(input_buffer.current_text, "")

func test_text_input_appends():
	watch_signals(input_buffer)
	input_buffer.handle_text_input("a")
	assert_eq(input_buffer.current_text, "a")
	assert_signal_emitted(input_buffer, "input_changed", ["a"])
	
	input_buffer.handle_text_input("b")
	assert_eq(input_buffer.current_text, "ab")
	assert_signal_emitted(input_buffer, "input_changed", ["ab"])

func test_backspace_removes_char():
	input_buffer.current_text = "abc"
	watch_signals(input_buffer)
	
	input_buffer.handle_backspace()
	assert_eq(input_buffer.current_text, "ab")
	assert_signal_emitted(input_buffer, "input_changed", ["ab"])

func test_backspace_empty_does_nothing():
	input_buffer.current_text = ""
	watch_signals(input_buffer)
	
	input_buffer.handle_backspace()
	assert_eq(input_buffer.current_text, "")
	assert_signal_not_emitted(input_buffer, "input_changed")

func test_clear_resets_text():
	input_buffer.current_text = "abc"
	watch_signals(input_buffer)
	
	input_buffer.clear()
	assert_eq(input_buffer.current_text, "")
	assert_signal_emitted(input_buffer, "input_changed", [""])
	assert_signal_emitted(input_buffer, "input_cleared")

func test_max_length():
	input_buffer.max_length = 3
	input_buffer.handle_text_input("abc")
	assert_eq(input_buffer.current_text, "abc")
	
	input_buffer.handle_text_input("d")
	assert_eq(input_buffer.current_text, "abc")
