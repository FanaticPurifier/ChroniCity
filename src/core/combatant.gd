extends RefCounted
class_name Combatant

var name: String
var hp: int
var max_hp: int
var attack_power: int
var defense: int
var stance: Globals.Stance
var agent_data: Agent

func _init(source_agent: Agent, battle_stance: Globals.Stance):
	agent_data = source_agent
	stance = battle_stance
	name = source_agent.agent_name
	max_hp = source_agent.max_health
	hp = max_hp
	attack_power = source_agent.attack_power
	defense = source_agent.defense


func is_alive() -> bool:
	return hp > 0

func take_damage(damage: int):
	hp -= damage
	if hp < 0:
		hp = 0
