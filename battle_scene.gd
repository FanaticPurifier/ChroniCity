extends Node

@onready var scroll_container = $ScrollContainer
@onready var label = $ScrollContainer/Label
@onready var timer = $Timer

func _ready():
	run_battle()

func run_battle():
	# 1. Get player's team from GameManager
	var player_team: Array[Agent] = GameManager.player_team_for_battle

	var enemy_team: Array[Agent] = []
	for i in 3:
		enemy_team.append(RosterManager.generate_agent())

	# 2. Pass the teams to BattleResolver
	var combat_log_array = BattleResolver.resolve_battle(player_team, enemy_team)

	# 3. Display the result.
	label.text = "\n".join(combat_log_array)
	timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://aftermath_scene.tscn")
