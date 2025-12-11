# Research for Typing RPG Game Core Mechanics

## State Machine Implementation

**Decision**: Implement a code-only state machine directly in GDScript.

**Rationale**: This approach provides maximum control and avoids introducing external dependencies, aligning with the project's goal of careful approval for community extensions. It also reduces the maintenance burden associated with third-party plugins.

**Alternatives Considered**:
*   "Easy State Machine" plugin: Lightweight and signal-driven, good for Godot 4. However, the decision was to avoid external dependencies where a robust in-house solution is feasible.
*   "Godot-FiniteStateMachine" plugin: Integrates well with the node system. Similar rationale for rejection as "Easy State Machine".
*   "VisualFSM" plugin: Rejected due to potential lack of maintenance for Godot 4.
