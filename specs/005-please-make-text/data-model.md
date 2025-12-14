# Data Model

## Signals (The Contract)

The core integration point is the signal emitted by the `InputBuffer`.

```gdscript
# Emitted whenever the text in the buffer changes (typing, backspace, clear)
signal input_changed(new_text: String)

# Emitted when the buffer is cleared explicitly (e.g. after a successful cast)
signal input_cleared()
```

## Entities

### 1. InputBuffer (Node)
Manages the current state of the typed string.

**Properties:**
- `current_text: String`: The raw string currently typed.
- `max_length: int`: Optional limit to prevent infinite strings.

**Methods:**
- `_on_text_input(char)`: Appends char.
- `_on_backspace()`: Removes last char.
- `clear()`: Resets text to empty.
- `get_text() -> String`: Returns current text.

### 2. TypableLabel (RichTextLabel)
A UI component that visualizes a target string and highlights the portion matching the `InputBuffer`.

**Properties:**
- `target_text: String`: The word/phrase the player needs to type.
- `active_color: Color`: Color for matched characters (default: Red).
- `default_color: Color`: Color for unmatched characters (default: White).
- `match_mode: Enum`: 
    - `PREFIX`: Matches from start (standard typing game).
    - `ANY`: Matches anywhere (not needed for MVP but good for future).

**State:**
- `is_matching: bool`: True if current input is a valid prefix of `target_text`.

### 3. InputFeedbackBar (Label)
Visualizes exactly what is in the buffer.

**Properties:**
- `placeholder_text: String`: Text to show when empty (optional).

## Logic Flow

1. **Player** presses 'F'.
2. **InputHandler** emits `text_input('f')`.
3. **InputBuffer** receives signal, appends 'f', emits `input_changed('f')`.
4. **InputFeedbackBar** receives `input_changed`, sets text to "f".
5. **TypableLabel** (for "Fire") receives `input_changed`.
   - Checks if "f" is prefix of "Fire". Yes.
   - Updates BBCode: `[color=red]F[/color][color=white]ire[/color]`.
6. **TypableLabel** (for "Water") receives `input_changed`.
   - Checks if "f" is prefix of "Water". No.
   - Updates BBCode: `[color=white]Water[/color]`.
