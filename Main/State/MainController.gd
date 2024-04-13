extends Node

var collected_critters: Array[NodePath] = []
signal critter_collected(player: NodePath, critter: NodePath)
signal critter_saved(critter: NodePath)
@export var critters_to_collect: int = 3;

signal player_switched(player: NodePath)
@export var players: Array[NodePath] = []
var active_player_index: int = 0

func add_critter(_player, critter):
	collected_critters.append(critter)

func get_active_player():
	return players[active_player_index]

func get_active_player_node():
	return get_node(players[active_player_index])

func on_player_switched():
	cycle_active_players()
	var active = get_active_player()
	emit_signal("player_switched", active)

func cycle_active_players():
	active_player_index = 0 if active_player_index >= players.size() - 1 else active_player_index + 1

func remove_critter(path):
	if path in collected_critters:
		collected_critters.erase(path)
		
func _ready():
	set_process_input(true)

func _input(_ev):
	if Input.is_key_pressed(KEY_TAB):
		on_player_switched()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if collected_critters.size() >= critters_to_collect:
		# We have collected all the critters
		# Emit a signal to the parent node
		pass
