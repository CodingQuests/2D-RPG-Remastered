extends CharacterBody2D

@export var speed = 80
var Dying = false
var attacking = false
var knockback_dir = Vector2.ZERO
var knockback = Vector2.ZERO
############################
var dash_speed = 1000
var dash_length = 0.5
var is_dashing = false
@onready var dashNode = preload("res://Scenes/Player/Dash.tscn")
############################
#RayCast Collision Check
var colliding
@onready var bodyCast = $BodyCheck
var Lastinput_vector
func _physics_process(delta):
	colliding = bodyCast.is_colliding()
	check_input(delta)

func check_input(delta):
	if !Dying:
		if Input.is_action_just_pressed("Attack"):
			$AnimationTree.get("parameters/playback").travel("Attack")
			attacking = true
		if attacking == false and is_dashing == false:
			var input_vector = Vector2.ZERO
			input_vector.x = Input.get_action_strength("WalkRight") - Input.get_action_strength("WalkLeft") 
			input_vector.y = Input.get_action_strength("WalkDown") - Input.get_action_strength("WalkUp") 
			input_vector = input_vector.normalized()
			
			if input_vector == Vector2.ZERO:
				$AnimationTree.get("parameters/playback").travel("Idle")
			else:
				$AnimationTree.get("parameters/playback").travel("Walk")
				$AnimationTree.set("parameters/Idle/blend_position", input_vector)
				$AnimationTree.set("parameters/Walk/blend_position", input_vector)
				$AnimationTree.set("parameters/Attack/blend_position", input_vector)
				$AnimationTree.set("parameters/Death/blend_position", input_vector)
				Lastinput_vector = input_vector
				velocity = input_vector*speed
				move_and_slide()
			
			bodyCast.target_position = input_vector*50
			if Input.is_action_just_pressed("Dash"):
				if !colliding:
					is_dashing = true
		else:
			velocity = Vector2(0,0)
		dash()

func dash():
	if is_dashing:
		if !colliding:
			var tween = create_tween()
			var direction = ($AnimationTree.get("parameters/Idle/blend_position"))
			tween.tween_property(self, "position", position + (direction*Vector2(35,35)), 0.2)
			var dashTemp = dashNode.instantiate()
			dashTemp.direction = direction
			dashTemp.global_position = global_position + Vector2(0,-19)
			get_parent().add_child(dashTemp)
			tween.tween_callback(finishDash)
func finishDash():
	is_dashing = false
	pass



func _on_attack_detector_area_body_entered(body):
	if "mob" in body.name:
		body.hit()


func _on_animation_tree_animation_finished(anim_name):
	if "Attack" in anim_name:
		attacking = false


func hit():
	Game.player_health -= 1
	if Game.player_health <= 0:
		Dying = true
		$AnimationTree.get("parameters/playback").travel("Death")
		await $AnimationTree.animation_finished
		ChangeScene.changeScene("GameOver")
		$PlayerSprite.queue_free()
		
