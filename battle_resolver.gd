extends Node

func resolve_battle(player_team: Array[Agent], enemy_team: Array[Agent]) -> Array[String]:
	var combat_log: Array[String] = []

	# Calculate total stats for each team.
	var player_total_power = 0
	var player_current_health = 0
	for agent in player_team:
		player_total_power += agent.attack_power
		player_current_health += agent.health

	var enemy_total_power = 0
	var enemy_current_health = 0
	for agent in enemy_team:
		enemy_total_power += agent.attack_power
		enemy_current_health += agent.health
	
	combat_log.append("Battle Start!")
	combat_log.append("Player HP: %d | Enemy HP: %d" % [player_current_health, enemy_current_health])
	combat_log.append("--------------------")

	# 2. The Battle Loop.
	var turn = 1
	while player_current_health > 0 and enemy_current_health > 0:
		combat_log.append("Turn %d:" % turn)
		
		# Player attacks enemy.
		enemy_current_health -= player_total_power
		combat_log.append("-> Player team attacks for %d damage!" % player_total_power)
		
		# Check if the enemy team is defeated.
		if enemy_current_health <= 0:
			break
			
		# Enemy attacks player.
		player_current_health -= enemy_total_power
		combat_log.append("-> Enemy team attacks for %d damage!" % enemy_total_power)
		
		combat_log.append("Player HP: %d | Enemy HP: %d" % [player_current_health, enemy_current_health])
		combat_log.append("--------------------")
		turn += 1

	# 3. Determine the winner and add it to the log.
	if player_current_health > 0:
		combat_log.append("PLAYER TEAM WINS!")
		GameManager.battle_completed.emit("VICTORY")
	else:
		combat_log.append("ENEMY TEAM WINS!")
		GameManager.battle_completed.emit("DEFEAT")
		
	return combat_log
