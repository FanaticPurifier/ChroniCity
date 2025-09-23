extends Control

@onready var result_label = $VBoxContainer/ResultLabel

func _ready():
    result_label.text = GameManager.last_battle_result

func _on_return_to_office_btn_pressed() -> void:
    Globals.change_scene("OFFICE")
