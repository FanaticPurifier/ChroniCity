extends Node

# This is the "announcement"
signal battle_completed(result: String)
var last_battle_result: String = "NO RESULT"

var selected_mission_data: MissionData = null
var player_team_for_battle: Array[Dictionary] = []

func _ready():
	# We connect our own signal to our own function.
	# When "battle_completed" is emitted from ANYWHERE, this manager
	# will call its own "_on_battle_completed" function.
	battle_completed.connect(_on_battle_completed)

# This function is now the ONLY place where last_battle_result is written to.
func _on_battle_completed(result: String):
	last_battle_result = result
	print("GameManager received battle_completed signal with result: ", result)
