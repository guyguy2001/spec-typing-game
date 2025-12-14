# Quickstart: Visual Typing Feedback

## Integration Guide

### 1. Adding Input Handling
In your main game/combat scene (`Arena`):

1. Ensure an instance of `InputBuffer` is present.
2. Connect `InputHandler` signals to `InputBuffer`.

```gdscript
# Arena.gd
func _ready():
    var input_buffer = InputBuffer.new()
    add_child(input_buffer)
    
    # Assuming input_handler is already available
    input_handler.text_input.connect(input_buffer.handle_text_input)
    input_handler.backspace_pressed.connect(input_buffer.handle_backspace)
    
    # Expose buffer to UI
    hud.connect_input_signals(input_buffer)
```

### 2. Making Text Typable
Replace any standard `Label` that represents a typing target with `TypableLabel`.

1. In the Scene tree, change type of `Label` to `RichTextLabel` and attach `res://src/ui/typable_label.gd`.
2. Set `target_text` property in the inspector or code.
3. Connect the `InputBuffer` signal.

```gdscript
# In a container that manages the label (e.g., AbilityIcon)
func setup(text: String, input_buffer: InputBuffer):
    typable_label.target_text = text
    # The label needs to subscribe to the global or passed input signal
    input_buffer.input_changed.connect(typable_label.on_input_changed)
```

### 3. Adding the Input Bar
Add the `InputFeedbackBar` component to your HUD scene.

1. Instantiate `res://src/ui/input_feedback_bar.tscn` in your `HUD`.
2. Connect it to the `InputBuffer` signal similarly to the labels.
