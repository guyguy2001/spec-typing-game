extends GutTest

var typable_label: TypableLabel

func before_each():
	typable_label = TypableLabel.new()
	add_child_autofree(typable_label)
	
func test_initial_display_empty_input():
	typable_label.target_text = "Fire"
	typable_label.update_text_display("")
	assert_eq(typable_label.text, "[color=#FFFFFF]Fire[/color]")

func test_matching_prefix():
	typable_label.target_text = "Fire"
	typable_label.update_text_display("F")
	assert_eq(typable_label.text, "[color=#FF0000]F[/color][color=#FFFFFF]ire[/color]")

func test_full_match():
	typable_label.target_text = "Fire"
	typable_label.update_text_display("Fire")
	assert_eq(typable_label.text, "[color=#FF0000]Fire[/color][color=#FFFFFF][/color]")

func test_incorrect_prefix_first_char():
	typable_label.target_text = "Fire"
	typable_label.update_text_display("G")
	assert_eq(typable_label.text, "[color=#FFFFFF]Fire[/color]")

func test_incorrect_prefix_middle_char():
	typable_label.target_text = "Fire"
	typable_label.update_text_display("Fj") # j is incorrect
	assert_eq(typable_label.text, "[color=#FFFFFF]Fire[/color]")

func test_incorrect_prefix_case_mismatch():
	typable_label.target_text = "Fire"
	typable_label.update_text_display("f") # lower case 'f'
	assert_eq(typable_label.text, "[color=#FFFFFF]Fire[/color]")

func test_empty_target_text():
	typable_label.target_text = ""
	typable_label.update_text_display("F")
	assert_eq(typable_label.text, "")
