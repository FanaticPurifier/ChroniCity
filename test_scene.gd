extends Node

@onready var label = $Label

func _on_button_pressed():
	# 1. Create the teams using our factory.
	var player_team: Array[Agent] = []
	for i in 3:
		player_team.append(RosterManager.generate_agent())

	var enemy_team: Array[Agent] = []
	for i in 3:
		enemy_team.append(RosterManager.generate_agent())

	# 2. Pass the teams to our new resolver.
	var result_string = BattleResolver.resolve_battle(player_team, enemy_team)

	# 3. Display the result.
	label.text = result_string
