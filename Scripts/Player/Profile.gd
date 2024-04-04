extends Control



func _process(delta):
	get_node("stats_label").text = "Player Health: %s\n Player Attack: %s\n Player Defense: %s" % [Game.player_health,Game.player_damage,Game.player_defense]
