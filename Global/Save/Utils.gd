extends Node

const SAVE_PATH: String = "res://savegame.bin"
const SAVE_PASS: String = "password"

func save_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var dic = {
		"playerLVL": Game.playerLVL
	}
	var jstr = JSON.stringify(dic)
	file.store_line(jstr)


func load_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return
	if file == null:
		return
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			for i in current_line:
				Game.playerLVL = current_line["playerLVL"]

