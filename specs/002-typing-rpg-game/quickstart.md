# Quickstart Guide: Typing RPG Game

This guide provides instructions to quickly set up and run the Godot project for the Typing RPG Game.

## Prerequisites

*   **Godot Engine**: Version 4.x installed on your system. You can download it from [Godot Engine website](https://godotengine.org/download).
*   **Git**: For cloning the repository.

## Setup Instructions

1.  **Clone the Repository**:
    If you haven't already, clone the project repository to your local machine:
    ```bash
    git clone [REPOSITORY_URL]
    cd spec-typing-game
    ```
    (Note: Replace `[REPOSITORY_URL]` with the actual URL of this Git repository.)

2.  **Open Project in Godot**:
    *   Launch the Godot Engine.
    *   In the Project Manager, click on the "Import" button.
    *   Navigate to the cloned `spec-typing-game` directory and select the `project.godot` file.
    *   Click "Open" to add the project to your Godot Project Manager.
    *   Select the project from the list and click "Edit" to open it in the Godot editor.

3.  **Run the Game**:
    *   Once in the Godot editor, you can run the main scene by clicking the "Play" button (looks like a triangle) in the top-right corner of the editor, or by pressing `F5`.
    *   The game should start in a new window, presenting the arena mode.

## Project Structure Overview

The core game logic and assets are organized as follows:

*   `res://src/abilities/`: Contains GDScript files defining individual abilities.
*   `res://src/characters/`: Contains scenes and scripts for player and enemy characters.
*   `res://src/core/`: Houses the main game loop, state machine implementation, and global input handling.
*   `res://src/ui/`: Contains UI scenes (e.g., health bars, typing input display) and their associated scripts.
*   `res://src/util/`: General utility scripts and helper functions.
*   `res://tests/`: Unit tests for various game components using the GUT framework.

## Recommended Development Practices

*   **Type Hinting**: All GDScript code should be type-hinted as much as possible for clarity and maintainability.
*   **GUT for Testing**: Write unit tests for new features and bug fixes using the GUT framework.
*   **State Machine**: Follow the custom code-only state machine pattern implemented in `res://src/core/` for managing game flow.
