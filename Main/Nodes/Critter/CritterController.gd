# Manages critter behaviors as it relates to the global game state
extends CharacterBody2D

func _on_critter_collected(player_path, critter_path):
	if critter_path == get_path():

		var critter = get_node(critter_path)
		
		if !critter.get("is_following"):
			critter.set("is_following", true)
			critter.get_node("Follow").set("target", player_path)

func _ready():
	var main_controller = get_node("/root/Main/MainController")
	main_controller.connect("critter_collected", _on_critter_collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
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
