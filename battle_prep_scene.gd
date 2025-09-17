extends Control

@onready var agent_list_container = $VBoxContainer/AgentListContainer
@onready var deploy_button = $VBoxContainer/Deploy_btn


func _ready():
	# Connect the deploy button's signal
	deploy_button.pressed.connect(_on_deploy_button_pressed)
	
	# Populate the agent list
	populate_agent_list()


func populate_agent_list():
	# Loop through every agent in our global roster
	for agent in RosterManager.roster:
		# Create a new CheckBox node from code
		var check_box = CheckBox.new()
		
		# Set its text to the agent's name
		check_box.text = agent.agent_name
		
		# Store the actual agent resource on the check_box node
		# This is a handy way to keep a reference to the data.
		check_box.set_meta("agent_data", agent)
		
		# Add our newly created check_box to the container in the scene
		agent_list_container.add_child(check_box)


func _on_deploy_button_pressed():
	# Clear out the old team from the last battle
	GameManager.player_team_for_battle.clear()
	
	# Go through all the checkboxes we created
	for check_box in agent_list_container.get_children():
		# If the box is checked...
		if check_box.button_pressed:
			# ...get the agent data we stored in it and add it to our team.
			var agent: Agent = check_box.get_meta("agent_data")
			GameManager.player_team_for_battle.append(agent)
	
	# Optional: Add a check to make sure a team was selected
	if GameManager.player_team_for_battle.is_empty():
		print("No agents selected!")
		return
		
	# Go to the battle!
	get_tree().change_scene_to_file("res://battle_scene.tscn")
