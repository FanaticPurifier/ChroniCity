extends Node

func resolve_battle(player_team_setup: Array[Dictionary], enemy_team_setup: Array[Dictionary], combat_log_label) -> Array[String]:
	var combat_log = combat_log_label.text

	var player_combatants: Array[Combatant] = _create_combatant_list(player_team_setup)
	var enemy_combatants: Array[Combatant] = _create_combatant_list(enemy_team_setup)

	combat_log_label.append_text("\n--- BATTLE START ---")

	var turn = 1
	while _is_team_alive(player_combatants) and _is_team_alive(enemy_combatants):
		combat_log_label.append_text("\n--- Turn %d ---" % turn)
		await get_tree().create_timer(0.3).timeout
		
		# Player's turn phase
		var player_attacker = _get_next_attacker(player_combatants, turn)
		if player_attacker:
			# The target now depends on the attacker!
			var enemy_target = _get_target(player_attacker, enemy_combatants) 
			if enemy_target:
				_perform_attack(player_attacker, enemy_target, combat_log_label)
				await get_tree().create_timer(0.2).timeout

		# Enemy's turn phase (only proceeds if they're still alive)
		if _is_team_alive(enemy_combatants):
			var enemy_attacker = _get_next_attacker(enemy_combatants, turn)
			if enemy_attacker:
				var player_target = _get_target(enemy_attacker, player_combatants)
				if player_target:
					_perform_attack(enemy_attacker, player_target, combat_log_label)
					await get_tree().create_timer(0.2).timeout

		turn += 1
		if turn > 100:
			combat_log_label.append_text("\n!! BATTLE TIMED OUT !!")
			break

	combat_log_label.append_text("\n--- BATTLE END ---")
	if _is_team_alive(player_combatants):
		GameManager.battle_completed.emit("VICTORY")
		combat_log_label.append_text("\nVICTORY!")
	else:
		GameManager.battle_completed.emit("DEFEAT")
		combat_log_label.append_text("\nDEFEAT!")
		
	return combat_log


# --- Private Helper Functions ---

func _create_combatant_list(team_setup_data: Array[Dictionary]) -> Array[Combatant]:
	var combatants: Array[Combatant] = []
	# Loop through the dictionaries.
	for setup_data in team_setup_data:
		var agent: Agent = setup_data["agent"]
		var stance: Globals.Stance = setup_data["stance"]
		# Pass both pieces of data to the Combatant constructor.
		combatants.append(Combatant.new(agent, stance))
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

func _get_target(attacker: Combatant, potential_targets: Array[Combatant]) -> Combatant:
	var living_targets = _get_living_combatants(potential_targets)
	if living_targets.is_empty():
		return null

	# The new logic!
	match attacker.agent_data.target_preference: # We need to add agent_data to Combatant
		Globals.TargetPreference.FRONT:
			return living_targets[0] # The first living target is the front-liner
		Globals.TargetPreference.BACK:
			return living_targets[-1] # The last living target is at the back
		Globals.TargetPreference.LOWEST_HEALTH:
			living_targets.sort_custom(func(a, b): return a.hp < b.hp)
			return living_targets[0]
		Globals.TargetPreference.HIGHEST_ATTACK:
			living_targets.sort_custom(func(a, b): return a.attack_power > b.attack_power)
			return living_targets[0]
	
	# Default case if something goes wrong
	return living_targets.pick_random()

func _get_next_attacker(team: Array[Combatant], turn_number: int) -> Combatant:
	var living_attackers = _get_living_combatants(team)
	if living_attackers.is_empty():
		return null
	return living_attackers[(turn_number - 1) % living_attackers.size()]

func _perform_attack(attacker: Combatant, target: Combatant, combat_log_label):
	var attack_mod = 1.0
	var defense_mod = 1.0

	# Announce the stance with italics
	match attacker.stance:
		Globals.Stance.AGGRESSIVE:
			attack_mod = 1.25
			combat_log_label.append_text("\n[i]-> %s takes an AGGRESSIVE stance![/i]" % attacker.name)
		Globals.Stance.DEFENSIVE:
			attack_mod = 0.75
			combat_log_label.append_text("\n[i]-> %s takes a DEFENSIVE stance![/i]" % attacker.name)
		Globals.Stance.SUPPORT:
			combat_log_label.append_text("\n[i]-> %s takes a SUPPORT stance.[/i]" % attacker.name)

	match target.stance:
		Globals.Stance.DEFENSIVE:
			defense_mod = 1.5

	var damage = (attacker.attack_power * attack_mod) - (target.defense * defense_mod)
	damage = max(1, damage)
	
	# Use bold for names
	combat_log_label.append_text("\n   [b]%s[/b] attacks [b]%s[/b]!" % [attacker.name, target.name])
	
	target.take_damage(damage)
	
	# Use color for damage numbers and health status
	var health_string = "[color=green]%d/%d[/color]" % [target.hp, target.max_hp]
	combat_log_label.append_text("\n   ...deals [color=red]%d damage[/color]. (%s HP: %s)" % [damage, target.name, health_string])
	
	if not target.is_alive():
		# Make defeated messages stand out
		combat_log_label.append_text("\n   [b][color=gray]%s has been defeated![/color][/b]" % target.name)
