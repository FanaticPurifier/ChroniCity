extends Control

@onready var roster_label = $VBoxContainer/RosterLabel

func _on_view_roster_btn_pressed() -> void:
	var roster_text = "Current Roster: \n"
	for agent in RosterManager.roster:
		roster_text += "- %s\n" % agent.agent_name
	roster_label.text = roster_text

func _on_select_mission_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://mission_select_scene.tscn")
