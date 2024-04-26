extends CharacterBody2D

# Reference to the AnimatedSprite node
@onready var Anim = $Anim
@onready var HitDetector = $HitDetectorArea/CollisionShape2D
# Reference to the player node
@export var player: Node2D
# Movement speed of the AI mob
var speed: float = 20.0
# Enum representing different states of the AI mob
enum MobState {
	IDLE,
	CHASING,
	ATTACKING,
	DEATH
}

var currentState

func _ready():
	HitDetector.disabled = true
	currentState = MobState["IDLE"]
	
func _physics_process(delta):
	if is_instance_valid(player):
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
			3:
				$AnimationPlayer.play("Death")
				await $AnimationPlayer.animation_finished
				self.queue_free()

		if direction.x < 0:
			Anim.flip_h = true
			HitDetector.position = Vector2(-8.5, -3)
		else:
			Anim.flip_h = false
			HitDetector.position = Vector2(8.5, -3)
		move_and_slide()

func _on_player_detector_area_body_entered(body):
	if "Player" in body.name:
		if currentState != MobState["DEATH"]:
			currentState = MobState["CHASING"]


func _on_player_detector_area_body_exited(body):
	if "Player" in body.name:
		if currentState != MobState["DEATH"]:
			currentState = MobState["IDLE"]

func _on_attack_detector_area_body_entered(body):
	if "Player" in body.name:
		if currentState != MobState["DEATH"]:
			currentState = MobState["ATTACKING"]
			
func _on_attack_detector_area_body_exited(body):
	if "Player" in body.name:
		if currentState != MobState["DEATH"]:
			await Anim.animation_finished
			currentState = MobState["CHASING"]

func hit():
	currentState = MobState["DEATH"]
	


func _on_anim_frame_changed():
	if currentState == MobState["ATTACKING"]:
		if Anim.frame == 1:
			HitDetector.disabled = false
		if Anim.frame == 2:
			HitDetector.disabled = true

func _on_hit_detector_area_body_entered(body):
	if "Player" in body.name:
		body.hit()
