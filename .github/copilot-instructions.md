# CthoniCity AI Agent Instructions

This is a Godot 4.5 game project using GDScript. The project is a tactical game with roster management and turn-based battle mechanics.

## Project Architecture

### Core Components

- **Game State Management**: Singleton autoload nodes in `src/autoload/`
  - `game_manager.gd`: Handles battle state and mission selection
  - `globals.gd`: Contains shared enums and constants
  - `roster_manager.gd`: Manages agent roster and agent generation

### Directory Structure

- `src/`: Core game logic and systems
  - `autoload/`: Global singletons
  - `core/`: Core game systems and data structures
  - `game/`: Scene-specific logic and gameplay systems
- `scenes/`: Godot scene files (.tscn)
  - `components/`: Reusable scene components
  - `screens/`: Main game screens
- `data/`: Game data assets
  - `agents/`: Agent-related resources
  - `missions/`: Mission configurations

### Key Patterns

1. **Signal-based Communication**:

   - Use Godot's signal system for cross-scene communication
   - Example: `battle_completed` signal in `game_manager.gd` for battle results

2. **Resource Management**:

   - Game data is stored in GDScript Resource objects
   - See `src/core/agents/agent.gd` for an example

3. **Scene Organization**:
   - Main gameplay flows through distinct scenes (mission_select → battle_prep → battle → aftermath)
   - Each scene has a corresponding GDScript file in `src/game/`

## Development Workflow

1. **Project Setup**:

   - Uses Godot 4.5 with Forward Plus rendering
   - Main scene is specified in `project.godot`
   - Required plugins: Todo_Manager, script-ide

2. **Adding New Features**:

   - Place new scenes under appropriate `scenes/` subdirectory
   - Implement logic in corresponding `src/game/` script
   - Register any autoload nodes in `project.godot`

3. **Code Style**:
   - Use PascalCase for classes/resources
   - Use snake_case for variables and functions
   - Implement signal connections in `_ready()`
   - Document public APIs with comments

## Common Tasks

- **Adding New Agents**: Extend the `Agent` resource in `src/core/agents/agent.gd`
- **Modifying Battle Logic**: See `battle_resolver.gd` for combat mechanics
- **Adding Game States**: Use the state machine system in `addons/godot_state_charts/`

For debugging, use the Script IDE addon which provides enhanced navigation and outlining features.
