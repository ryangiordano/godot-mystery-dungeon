extends Node2D

var target: NodePath
@export var cooldown_seconds: float = 1.0
var current_cooldown: float = 0.0
var target_position: Vector2
@export var speed = 70 # Define the speed at which the node will follow the target
@export var radius = 35 # Define the radius of the circle around the target

func _physics_process(delta):
	if target and target != NodePath():
		var body = get_parent()
		var target_node = get_node(target)
		current_cooldown = max(current_cooldown - delta, 0)
		
		var within_range = target_node.global_position.distance_to(get_parent().global_position) < radius
		if target_node and !within_range:
			if current_cooldown <= 0 or !target_position:
				current_cooldown = cooldown_seconds
				var angle = randf_range(0, 2 * PI) # Get a random angle
				target_position = Vector2(cos(angle), sin(angle)) * radius # Calculate the offset from the target

			var move_to = target_node.global_position + target_position
			var direction: Vector2 = (move_to - body.global_position).normalized()
			body.velocity = direction * speed
			return body.move_and_slide()
		
	get_parent().velocity = Vector2.ZERO
	# body.global_position += direction * speed * delta
			