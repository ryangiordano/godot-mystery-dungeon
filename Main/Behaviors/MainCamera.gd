extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	position_smoothing_enabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var main_controller = get_node("/root/Main/MainController")
	var focus_node = main_controller.get_active_player_node()
	if focus_node:
		global_position = focus_node.global_position
	pass
