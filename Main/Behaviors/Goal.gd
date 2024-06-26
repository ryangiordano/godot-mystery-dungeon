extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies()
	if bodies:
		for body in bodies:
			var main_controller = get_node("/root/Main/MainController")
			main_controller.emit_signal("critter_saved",
				body.get_path(),
			)