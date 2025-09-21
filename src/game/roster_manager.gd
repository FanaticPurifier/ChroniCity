# RosterManager.gd
extends Node

const AgentResource = preload("res://src/core/agents/agent.gd")

# A couple of simple lists to pull random names from
const FIRST_NAMES = ["John", "Mary", "David", "Sarah", "Peter", "Jane"]
const LAST_NAMES = ["Smith", "Jones", "Williams", "Brown", "Miller", "Davis"]

var roster: Array[Agent] = []

func _ready():
	if roster.is_empty():
		for i in 3:
			roster.append(generate_agent())
		print("Starting roster generated with %d agents." % roster.size())


func generate_agent() -> Agent:
	var new_agent = AgentResource.new()

	var first = FIRST_NAMES.pick_random()
	var last = LAST_NAMES.pick_random()
	new_agent.agent_name = "%s %s" % [first, last]

	new_agent.max_health = randi_range(80, 120)
	new_agent.health = new_agent.max_health # Start with full health
	new_agent.attack_power = randi_range(8, 15)
	new_agent.defense = randi_range(3, 8)

	# TODO: We'll add a random starting trait here later

	return new_agent
