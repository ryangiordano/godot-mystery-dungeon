extends Node

# Singleton pattern in GDScript
static var _instance = null

func _init():
	if _instance == null:
		_instance = self
	else:
		queue_free()

static func get_instance():
	return _instance