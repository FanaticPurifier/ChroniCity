extends Node

@onready var scroll_container = $ScrollContainer
@onready var label = $ScrollContainer/Label

func _ready():
	label.resized.connect(_scroll_to_bottom)

func _on_button_pressed():
	# 1. Create the teams using our factory.
	var player_team: Array[Agent] = []
	for i in 3:
		player_team.append(RosterManager.generate_agent())

	var enemy_team: Array[Agent] = []
	for i in 3:
		enemy_team.append(RosterManager.generate_agent())

	# 2. Pass the teams to our new resolver.
	var combat_log_array = BattleResolver.resolve_battle(player_team, enemy_team)

	# 3. Display the result.
	label.text = "\n".join(combat_log_array)

func _scroll_to_bottom():
	await get_tree().process_frame
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
