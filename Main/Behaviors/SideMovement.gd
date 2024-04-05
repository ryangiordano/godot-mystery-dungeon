extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_rotated = false

func _physics_process(_delta):
	# Add the gravity.
	# if not is_on_floor():
	# 	velocity.y += min(gravity * delta, 1000)

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("move_left", "move_right")

	var directionY = Input.get_axis("move_up", "move_down")
	
	# Flip the sprite based on the direction.
	var sprite = get_node("Sprite2D")
	var anim = get_node("MovementAnimationPlayer")
	var anim_rotate = get_node("RotationAnimationPlayer")
	if (directionX > 0):
		sprite.flip_h = false
		anim.play("walk-right")
		if (has_rotated == false):
			anim_rotate.play("rotate-left")
			has_rotated = true
	elif (directionX < 0):
		sprite.flip_h = true
		anim.play("walk-right")
		if (has_rotated == false):
			anim_rotate.play("rotate-right")
			has_rotated = true

	elif (directionY > 0):
		anim.play("walk-down")
		has_rotated = false
		anim_rotate.play("return")
	elif (directionY < 0):
		anim.play("walk-up")
		has_rotated = false
		anim_rotate.play("return")
	else:
		anim.play("idle")
		has_rotated = false
		anim_rotate.play("return")
	
	if (directionY > 0):
		velocity.y = -SPEED
	elif (directionY < 0):
		velocity.y = SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 10)

	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 10)

	move_and_slide()
