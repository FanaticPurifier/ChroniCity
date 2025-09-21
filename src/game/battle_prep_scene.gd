extends Control

@onready var agent_list_container = $VBoxContainer/AgentListContainer
@onready var deploy_button = $VBoxContainer/Deploy_btn

func _ready():
	deploy_button.pressed.connect(_on_deploy_button_pressed)
	populate_agent_list()


func populate_agent_list():
	# Go through every agent in our global roster.
	for agent in RosterManager.roster:
		# Create a horizontal container for each agent's row.
		var row = HBoxContainer.new()

		# Create the CheckBox like before.
		var check_box = CheckBox.new()
		check_box.text = agent.agent_name
		check_box.set_meta("agent_data", agent)
		row.add_child(check_box)

		# Create the OptionButton for stances.
		var stance_selector = OptionButton.new()
		# Loop through our global Stance enum and add each one as an item.
		for stance_name in Globals.Stance.keys():
			stance_selector.add_item(stance_name)
		row.add_child(stance_selector)

		# Add the completed row to our main list.
		agent_list_container.add_child(row)


func _on_deploy_button_pressed():
	GameManager.player_team_for_battle.clear()
	
	# Loop through each HBoxContainer row we created.
	for row in agent_list_container.get_children():
		var check_box: CheckBox = row.get_child(0) # First child is the checkbox
		
		if check_box.button_pressed:
			var stance_selector: OptionButton = row.get_child(1) # Second child is the dropdown
			
			var agent: Agent = check_box.get_meta("agent_data")
			# Get the index of the selected item (0=AGGR, 1=DEF, etc.)
			var selected_stance_index = stance_selector.get_selected_id() 
			# Use the index to get the actual enum value.
			var chosen_stance = Globals.Stance.values()[selected_stance_index]
			
			# We'll store this as a dictionary.
			GameManager.player_team_for_battle.append({
				"agent": agent,
				"stance": chosen_stance
			})

	if GameManager.player_team_for_battle.is_empty():
		print("Error: No agents selected for the mission.")
		return
		
	get_tree().change_scene_to_file("res://scenes/screens/battle/battle_scene.tscn")
