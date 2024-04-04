extends Node





func _on_play_pressed():
	ChangeScene.changeScene("World")
	


func _on_quit_pressed():
	get_tree().quit()
