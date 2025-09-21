extends Control

@onready var result_label = $VBoxContainer/ResultLabel

func _ready():
	result_label.text = GameManager.last_battle_result

func _on_return_to_office_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/office/office_scene.tscn")
