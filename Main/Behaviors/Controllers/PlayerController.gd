extends Node2D

@export var collected_companion: NodePath
signal companion_collected(path: NodePath)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var bodies = get_parent().get_node("Area2D").get_overlapping_bodies()
	if bodies:
		for body in bodies:
			if body.collision_layer == 2:
				emit_signal("companion_collected", get_parent().get_path())
					