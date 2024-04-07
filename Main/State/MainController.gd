extends Node

var collected_critters: Array[NodePath] = []
signal critter_collected(player: NodePath, critter: NodePath)

@export var critters_to_collect: int = 3;

func add_critter(_player, critter):
	collected_critters.append(critter)

func remove_critter(path):
	if path in collected_critters:
		collected_critters.erase(path)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	# connect("critter_collected", add_critter)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if collected_critters.size() >= critters_to_collect:
		# We have collected all the critters
		# Emit a signal to the parent node
		print("All critters collected")
	pass
