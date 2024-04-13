extends CharacterBody2D

@export var active = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	var main_controller = get_node("/root/Main/MainController");
	main_controller.connect("player_switched", _on_player_switched);

func _on_player_switched(player):
	if get_node(player) == self:
		active = true;
	else:
		active = false;
