extends Control

func _on_mission_1_btn_pressed() -> void:
	# Store some data about the chosen mission.
	# Later, this could be loaded from a file.
	GameManager.selected_mission_data = {
		"name": "The Whispering Docks",
		"difficulty": 1,
		"enemy_type": "Cultist"
	}
	
	# Go to the next screen in the loop.
	get_tree().change_scene_to_file("res://battle_prep_scene.tscn")


func _on_mission_2_btn_pressed() -> void:
	GameManager.selected_mission_data = {
		"name": "Subway Psychosis",
		"difficulty": 2,
		"enemy_type": "Eldritch"
	}
	
	get_tree().change_scene_to_file("res://battle_prep_scene.tscn")
