extends Node

@onready var scroll_container = $ScrollContainer
@onready var combat_log_label = $ScrollContainer/CombatLogLabel
@onready var timer = $Timer

func _ready():
	run_battle()

func run_battle():
	# 1. Get player's team from GameManager
	var player_team_setup = GameManager.player_team_for_battle

	var enemy_team_setup: Array[Dictionary] = []
	for i in 3:
		var new_enemy_agent = RosterManager.generate_agent()
		enemy_team_setup.append({
			"agent": new_enemy_agent,
			"stance": Globals.Stance.AGGRESSIVE # Give enemies a default stance
		})

	# 2. Pass the teams to BattleResolver
	var combat_log_array = await BattleResolver.resolve_battle(player_team_setup, enemy_team_setup, combat_log_label)

	# 3. Display the result.
	#combat_log_label.text = "\n".join(combat_log_array)
	#timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/screens/aftermath/aftermath_scene.tscn")
