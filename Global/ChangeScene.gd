extends CanvasLayer

@onready var Anim = $AnimationPlayer

var Levels = {
	"MainMenu" : "res://Scenes/MainMenu.tscn",
	"World": "res://Scenes/World.tscn",
	"GameOver": "res://Scenes/GameOver.tscn",
}

func changeScene(SceneName):
	Anim.play("Trans_In")
	await Anim.animation_finished
	
	get_tree().change_scene_to_file(Levels[SceneName])
	
	Anim.play("Trans_Out")
	await Anim.animation_finished
	
