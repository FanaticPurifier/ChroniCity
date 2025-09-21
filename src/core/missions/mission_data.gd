extends Resource
class_name MissionData

@export_group("Mission Details")
@export var mission_name: String = "New Case File"
@export_multiline var description: String = "Details are sparse."

@export_group("Gameplay Data")
@export var difficulty: int = 1
@export var enemy_type: String = "Generic"
# We could add more here later, like rewards, enemy formations, etc.
