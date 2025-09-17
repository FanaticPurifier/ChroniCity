extends Node

# Takes two arrays of Agent resources and determines a winner.
func resolve_battle(player_team: Array[Agent], enemy_team: Array[Agent]) -> String:
	var player_total_power = 0
	for agent in player_team:
		player_total_power += agent.attack_power

	var enemy_total_health = 0
	for agent in enemy_team:
		enemy_total_health += agent.max_health # Using max_health for this simple calc

	# If the player's total power is greater than the enemy's total health, they win.
	if player_total_power > enemy_total_health:
		return "Player Team Wins!"
	else:
		return "Enemy Team Wins!"
