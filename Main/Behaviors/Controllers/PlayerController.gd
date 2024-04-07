extends CharacterBody2D

@export var collected_companion: NodePath

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var bodies = get_node("Area2D").get_overlapping_bodies()
	if bodies:
		for body in bodies:
			if body.collision_layer == 2:
				var main_controller = get_node("/root/Main/MainController")

				main_controller.emit_signal("critter_collected",
					get_path(),
					body.get_path(),
				)
					