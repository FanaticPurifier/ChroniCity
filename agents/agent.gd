class_name Agent extends Resource

@export_group("Identity")
@export var agent_name: String = "New Agent"

@export_group("Core Stats")
@export var health: int = 100
@export var max_health: int = 100
@export var attack_power: int = 10
@export var defense: int = 5

@export_group("Traits")
@export var traits: Array[String] = []
