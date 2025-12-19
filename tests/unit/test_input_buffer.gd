extends GutTest

var input_buffer: InputBuffer
var sender: GutInputSender

func before_each():
	input_buffer = InputBuffer.new()
	add_child_autofree(input_buffer)
	sender = GutInputSender.new(input_buffer)

func after_each():
	sender.release_all()
	sender.clear()

func send_character(char_str: String):
	var event = InputEventKey.new()
	event.pressed = true
	event.keycode = char_str.to_upper().to_utf8_buffer()[0]
	event.unicode = char_str.to_utf8_buffer()[0]
	sender.send_event(event)

func test_initial_state():
	assert_eq(input_buffer.current_text, "")

func test_text_input_appends():
	watch_signals(input_buffer)
	send_character("a")
	assert_eq(input_buffer.current_text, "a")
	assert_signal_emitted(input_buffer, "input_changed", ["a"])
	
	send_character("b")
	assert_eq(input_buffer.current_text, "ab")
	assert_signal_emitted(input_buffer, "input_changed", ["ab"])

func test_backspace_removes_char():
	input_buffer.current_text = "abc"
	watch_signals(input_buffer)
	
	sender.key_down(KEY_BACKSPACE)
	assert_eq(input_buffer.current_text, "ab")
	assert_signal_emitted(input_buffer, "input_changed", ["ab"])

func test_backspace_empty_does_nothing():
	input_buffer.current_text = ""
	watch_signals(input_buffer)
	
	sender.key_down(KEY_BACKSPACE)
	assert_eq(input_buffer.current_text, "")
	assert_signal_not_emitted(input_buffer, "input_changed")

func test_space_submits_word():
	input_buffer.current_text = "abc"
	watch_signals(input_buffer)
	
	sender.key_down(KEY_SPACE)
	assert_eq(input_buffer.current_text, "")
	assert_signal_emitted(input_buffer, "word_submitted", ["abc"])
	assert_signal_emitted(input_buffer, "input_changed", [""])

func test_max_length():
	input_buffer.max_length = 3
	input_buffer.current_text = "abc"
	
	send_character("d")
	assert_eq(input_buffer.current_text, "abc")
