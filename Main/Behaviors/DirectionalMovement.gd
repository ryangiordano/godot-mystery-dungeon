extends Node

@export var SPRITE: NodePath = NodePath("Sprite2D")
@export var ROTATE_ANIM: NodePath = NodePath("RotationAnimationPlayer")
@export var MOVEMENT_ANIM: NodePath = NodePath("MovementAnimationPlayer")

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_rotated = false

func _physics_process(_delta):
	var body = get_parent()
	if !body.get('active'):
		return
	var sprite = body.get_node(SPRITE)
	var rotate_anim = body.get_node(ROTATE_ANIM)
	var movement_anim = body.get_node(MOVEMENT_ANIM)

	# Add the gravity.
	# if not is_on_floor():
	# 	body.velocity.y += min(gravity * delta, 1000)

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		body.velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("move_left", "move_right")

	var directionY = Input.get_axis("move_up", "move_down")
	
	# Flip the sprite based on the direction.
	if (directionX > 0):
		sprite.flip_h = false
		movement_anim.play("walk-right")
		if (has_rotated == false):
			rotate_anim.play("rotate-left")
			has_rotated = true
	elif (directionX < 0):
		sprite.flip_h = true
		movement_anim.play("walk-right")
		if (has_rotated == false):
			rotate_anim.play("rotate-right")
			has_rotated = true

	elif (directionY > 0):
		movement_anim.play("walk-down")
		has_rotated = false
		rotate_anim.play("return")
	elif (directionY < 0):
		movement_anim.play("walk-up")
		has_rotated = false
		rotate_anim.play("return")
	else:
		movement_anim.play("idle")
		has_rotated = false
		rotate_anim.play("return")
	
	if (directionY > 0):
		body.velocity.y = -SPEED
	elif (directionY < 0):
		body.velocity.y = SPEED
	else:
		body.velocity.y = move_toward(body.velocity.y, 0, 10)

	if directionX:
		body.velocity.x = directionX * SPEED
	else:
		body.velocity.x = move_toward(body.velocity.x, 0, 10)
	
	if directionY:
		body.velocity.y = directionY * SPEED
	else:
		body.velocity.y = move_toward(body.velocity.y, 0, 10)

	body.move_and_slide()
