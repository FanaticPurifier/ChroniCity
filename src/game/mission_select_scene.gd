extends Control

# We'll drag our mission .tres files here in the editor.
@export var available_missions: Array[MissionData] = []

@onready var mission_list_container = $MissionListContainer # Make sure you have this node!

func _ready():
	# First, clear any old buttons that might be there from testing in the editor.
	for child in mission_list_container.get_children():
		child.queue_free()
	
	# Now, dynamically create a button for each mission in our array.
	for mission in available_missions:
		var button = Button.new()
		button.text = mission.mission_name
		
		# Here's the magic: connect the button's pressed signal to our
		# function, and "bind" the specific mission data to that signal.
		button.pressed.connect(_on_mission_selected.bind(mission))
		
		mission_list_container.add_child(button)

# A single function to handle any mission button being clicked.
func _on_mission_selected(mission_data: MissionData):
	# The "mission_data" argument is the one we bound to the signal.
	print("Selected mission: ", mission_data.mission_name)
	
	# Store the chosen mission data in our global manager.
	GameManager.selected_mission_data = mission_data
	
	# Go to the next screen.
	get_tree().change_scene_to_file("res://scenes/screens/battle_prep/battle_prep_scene.tscn")
