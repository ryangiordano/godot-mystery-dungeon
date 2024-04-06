# Manages critter behaviors as it relates to the global game state
extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
		# var velocity = Vector2() # Define a 2D vector for velocity
	var anim = get_node("AnimationPlayer") # Get the AnimatedSprite node
	var sprite = get_node("Sprite2D") # Get the AnimatedSprite node
	if velocity.x > 0:
		anim.play("run")
		sprite.flip_h = true

	elif velocity.x < 0:
		anim.play("run")
		sprite.flip_h = false

	if velocity.y > 0:
		anim.play("run")
	elif velocity.y < 0:
		anim.play("run")
	elif velocity.x <= 0 and velocity.y <= 0:
		anim.play("idle")
	pass
