extends Node

func resolve_battle(player_team: Array[Agent], enemy_team: Array[Agent]) -> Array[String]:
	var combat_log: Array[String] = []

	# Use our new class instead of dictionaries.
	var player_combatants: Array[Combatant] = _create_combatant_list(player_team)
	var enemy_combatants: Array[Combatant] = _create_combatant_list(enemy_team)

	combat_log.append("--- BATTLE START ---")

	var turn = 1
	while _is_team_alive(player_combatants) and _is_team_alive(enemy_combatants):
		combat_log.append("--- Turn %d ---" % turn)

		# Player's turn phase
		var player_attacker = _get_next_attacker(player_combatants, turn)
		if player_attacker:
			var enemy_target = _get_target(enemy_combatants) # Using new targeting logic
			if enemy_target:
				_perform_attack(player_attacker, enemy_target, combat_log)

		# Enemy's turn phase (only proceeds if they're still alive)
		if _is_team_alive(enemy_combatants):
			var enemy_attacker = _get_next_attacker(enemy_combatants, turn)
			if enemy_attacker:
				var player_target = _get_target(player_combatants)
				if player_target:
					_perform_attack(enemy_attacker, player_target, combat_log)

		turn += 1
		if turn > 100:
			combat_log.append("!! BATTLE TIMED OUT !!")
			break

	combat_log.append("--- BATTLE END ---")
	if _is_team_alive(player_combatants):
		GameManager.battle_completed.emit("VICTORY")
		combat_log.append("VICTORY!")
	else:
		GameManager.battle_completed.emit("DEFEAT")
		combat_log.append("DEFEAT!")
		
	return combat_log


# --- Private Helper Functions ---

func _create_combatant_list(agent_team: Array[Agent]) -> Array[Combatant]:
	var combatants: Array[Combatant] = []
	for agent in agent_team:
		combatants.append(Combatant.new(agent))
	return combatants

func _get_living_combatants(team: Array[Combatant]) -> Array[Combatant]:
	var living: Array[Combatant] = []
	for combatant in team:
		if combatant.is_alive():
			living.append(combatant)
	return living

func _is_team_alive(team: Array[Combatant]) -> bool:
	# This now uses our consolidated helper function.
	return not _get_living_combatants(team).is_empty()

func _get_target(team: Array[Combatant]) -> Combatant:
	var living_targets = _get_living_combatants(team)
	if living_targets.is_empty():
		return null
	# New Targeting Logic: Pick a random living target!
	return living_targets.pick_random()

func _get_next_attacker(team: Array[Combatant], turn_number: int) -> Combatant:
	var living_attackers = _get_living_combatants(team)
	if living_attackers.is_empty():
		return null
	return living_attackers[(turn_number - 1) % living_attackers.size()]

func _perform_attack(attacker: Combatant, target: Combatant, log: Array[String]):
	var damage = attacker.attack_power - target.defense
	damage = max(1, damage) # Ensure at least 1 damage
	
	log.append("-> %s attacks %s!" % [attacker.name, target.name])
	
	# Use the method on the Combatant object
	target.take_damage(damage)
	
	log.append("   ...deals %d damage. (%s HP: %d/%d)" % [damage, target.name, target.hp, target.max_hp])
	
	if not target.is_alive():
		log.append("   %s has been defeated!" % target.name)
