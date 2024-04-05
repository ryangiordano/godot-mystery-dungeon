extends Node2D

@export var target: NodePath
@export var cooldown_seconds: float = 1.0
var current_cooldown: float = 0.0
var target_position: Vector2
@export var speed = 70 # Define the speed at which the node will follow the target
@export var radius = 35 # Define the radius of the circle around the target

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_node(target))

func _process(delta):

	var target_node = get_node(target)
	current_cooldown = max(current_cooldown - delta, 0)
	print(current_cooldown)
	var within_range = target_node.global_position.distance_to(get_parent().global_position) < radius
	if target_node and !within_range:
		if current_cooldown <= 0 or !target_position:
			current_cooldown = cooldown_seconds
			var angle = randf_range(0, 2 * PI) # Get a random angle
			target_position = Vector2(cos(angle), sin(angle)) * radius # Calculate the offset from the target

		var t = target_node.global_position + target_position # Apply the offset to the target's position
		var direction: Vector2 = (t - get_parent().global_position).normalized()
		get_parent().global_position += direction * speed * delta
pass # Replace with function body.