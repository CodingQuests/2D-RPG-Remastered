extends CharacterBody2D

# Reference to the AnimatedSprite node
@onready var Anim = $Anim
# Reference to the player node
@export var player: Node2D
# Movement speed of the AI mob
var speed: float = 20.0
# Enum representing different states of the AI mob
enum MobState {
	IDLE,
	CHASING,
	ATTACKING,
}

var currentState

func _ready():
	currentState = MobState["IDLE"]
	
func _physics_process(delta):
	var direction = (player.global_position - self.global_position).normalized()
	match currentState:
		0:
			Anim.play("Idle")
			self.velocity = Vector2(0,0)
		1:
			Anim.play("Move")
			self.velocity = speed*direction
		2:
			Anim.play("Attack")
			self.velocity = Vector2(0,0)
	if direction.x < 0:
		Anim.flip_h = true
	else:
		Anim.flip_h = false
	move_and_slide()

func _on_player_detector_area_body_entered(body):
	if "Player" in body.name:
		currentState = MobState["CHASING"]


func _on_player_detector_area_body_exited(body):
	if "Player" in body.name:
		currentState = MobState["IDLE"]

func _on_attack_detector_area_body_entered(body):
	if "Player" in body.name:
		currentState = MobState["ATTACKING"]

func _on_attack_detector_area_body_exited(body):
	if "Player" in body.name:
		await Anim.animation_finished
		currentState = MobState["CHASING"]

func hit():
	self.queue_free()


