extends Node

enum Stance {
    AGGRESSIVE,
    DEFENSIVE,
    SUPPORT
}

enum TargetPreference {
    FRONT,
    BACK,
    LOWEST_HEALTH,
    HIGHEST_ATTACK
}

const SCENES = {
    # Main Screens
    "OFFICE": "res://scenes/screens/office/office_scene.tscn",
    "MISSION_SELECT": "res://scenes/screens/mission_select.tscn",
    "BATTLE": "res://scenes/screens/battle.tscn",
    "AFTERMATH": "res://scenes/screens/aftermath.tscn",
    "ROSTER": "res://scenes/screens/roster.tscn",
    
    # Components
    "AGENT_CARD": "res://scenes/components/agent_card.tscn",
    "BATTLE_UNIT": "res://scenes/components/battle_unit.tscn",
}
