# Feature Specification: Visual Typing Feedback and Input Bar

**Feature Branch**: `005-please-make-text`
**Created**: 2025-12-14
**Status**: Draft
**Input**: User description: "Please make the text I'm typing more visible, in the following ways: * Have an input bar below the abilities which automatically gets filled when I'm typing. (It doesn't have to be an actual input element - use whatever makes the most sense and won't break with focus switching) * Have the things I'm supposed to type (currently just the ability text, there'll be more things like this in the future) to show the progress I've written. I think if the word is "fire", and I type "fr", it should be "[RED]fi[/RED][WHITE]re[/WHITE]"."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Typist Input Visualization (Priority: P1)

As a player, I want to see exactly what I have typed so far in a dedicated area, so that I can track my current input sequence without looking away from the action.

**Why this priority**: Essential for the "more visible" goal. Players need immediate confirmation of their keystrokes.

**Independent Test**: Can be tested by typing anywhere in the game (combat state) and observing the input bar updating.

**Acceptance Scenarios**:

1. **Given** the player is in combat, **When** they type the letter "f", **Then** the input bar displays "f".
2. **Given** the input bar displays "f", **When** the player types "i", **Then** the input bar displays "fi".
3. **Given** the input bar displays "fi", **When** the player presses Backspace (if supported) or the input is cleared, **Then** the input bar updates to "f" or empty respectively.
4. **Given** the player is typing, **When** focus changes or game events occur, **Then** the input bar persists its state until explicitly cleared by game logic.

---

### User Story 2 - Target Text Progress Feedback (Priority: P2)

As a player, I want the ability names (and future typable objects) to visually reflect my typing progress, so that I know which characters I have matched or attempted.

**Why this priority**: Provides the core gameplay feedback loop. "Am I typing the right thing?"

**Independent Test**: Can be tested by spawning an enemy with abilities and typing partial matches.

**Acceptance Scenarios**:

1. **Given** an ability "fire", **When** the player types "f" (correct), **Then** the "f" in "fire" changes visual style (e.g., color) to indicate it is typed.
2. **Given** an ability "fire", **When** the player types "r" after "f" (making "fr", incorrect at 2nd char), **Then** the entire ability word "fire" resets to its default untyped visual style (e.g., white).
3. **Given** multiple abilities, **When** the player types a character, **Then** all matching ability texts update their visualization.

### Edge Cases

- **Empty Input**: Input bar should be empty or hidden when no text is typed.
- **Overshoot**: If user types more characters than the longest ability? (Input bar shows all, Target text highlights max length?).
- **No Match**: If user types characters that match nothing? (Input bar shows them, Target text does not highlight?).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST display a visual "Input Bar" UI element below the ability list.
- **FR-002**: The Input Bar MUST display the current contents of the player's input buffer in real-time.
- **FR-003**: The Input Bar MUST NOT be an interactive operating system form element (e.g., standard HTML/Godot LineEdit that captures focus) to prevent focus stealing issues.
- **FR-004**: System MUST render ability text (and future typable entities) using Rich Text capability to allow partial coloring/styling.
- **FR-005**: When the player types a character or modifies the input buffer, the system MUST update the visual style of only the typable texts whose prefixes match the current input buffer.
- **FR-006**: For any typable text whose prefix matches the current input buffer, the matched prefix MUST be styled in a distinct "active input" color (e.g., Red). The remaining characters of that word MUST retain their default "untyped" visual style.
- **FR-007**: If the typed character causes the input buffer to no longer be a prefix for a previously matching typable text, that text MUST revert to its default "untyped" visual style.

### Key Entities

- **InputBuffer**: The string of characters currently typed by the player.
- **TypableTarget**: A UI element (like Ability Icon Label) that represents a word to be typed.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Player input appears in the Input Bar within 1 frame of the keystroke.
- **SC-002**: Ability text updates its color highlights within 1 frame of the keystroke.
- **SC-003**: 100% of user keystrokes are reflected in the UI without losing game focus.