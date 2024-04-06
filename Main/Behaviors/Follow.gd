extends Node2D

@export var target: NodePath
@export var cooldown_seconds: float = 1.0
var current_cooldown: float = 0.0
var target_position: Vector2
@export var speed = 70 # Define the speed at which the node will follow the target
@export var radius = 35 # Define the radius of the circle around the target

func _ready():
	# TODO: We probably want to hook up this to a central hub like game state, rather than needing to hook up directly to the player. For now this works though.
	get_node("/root/Main/Player/PlayerController").connect("companion_collected", _on_companion_collected)

func _on_companion_collected(node_path: NodePath):
	if !target:
		target = node_path

func _process(delta):
	if target:
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
			
			body.global_position += direction * speed * delta