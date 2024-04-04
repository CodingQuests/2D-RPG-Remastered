extends CanvasLayer


var questNum = 0

func _on_accept_pressed():
	match questNum:
		1:
			Game.quest1Accepted = true
	self.queue_free()


func _on_decline_pressed():
	self.queue_free()
