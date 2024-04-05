extends Node

var speed = 100
var move_spacing = 25
var accel = 10
var cooldown_ms = 1000

var internal_cooldown_ms = cooldown_ms
var moving = false

@onready var mover: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D

func get_tile_size():
	var tilemap = get_node("/root/Main/TileMap")
	if (!tilemap):
		return
	var tile_size = tilemap.tile_set.tile_size.x
	return tile_size

func center_on_current_tile():
	var sprite = get_node("Sprite2D")

	var tile_size = get_tile_size()
	var tile_x = int(sprite.global_position.x / tile_size)
	var tile_y = int(sprite.global_position.y / tile_size)
	sprite.position = Vector2(tile_x * tile_size + tile_size / 2, tile_y * tile_size + tile_size / 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	center_on_current_tile()

func _process(_delta):
	var sprite = get_node("Sprite2D")

	internal_cooldown_ms = max(0, internal_cooldown_ms - 50)
	var tile_size = get_tile_size()

	# var tile_vector = Vector2(int(int(global_position.x) / tile_size), int(int(global_position.y) / tile_size))
	# print(tile_vector)
	if (internal_cooldown_ms > 0):
		return
	
	if Input.is_action_pressed("move_right"):
		internal_cooldown_ms = cooldown_ms

		sprite.position.x += tile_size
		# mover.play("walk_right")
	elif Input.is_action_pressed("move_left"):
		internal_cooldown_ms = cooldown_ms

		sprite.position.x -= tile_size
		# mover.play("walk_left")
	else:
		pass
		# mover.play("idle_right")

	if Input.is_action_pressed("move_down"):
		internal_cooldown_ms = cooldown_ms

		sprite.position.y += tile_size
		# mover.play("walk_down")
	elif Input.is_action_pressed("move_up"):
		internal_cooldown_ms = cooldown_ms

		sprite.position.y -= tile_size
		# mover.play("walk_up")
	else:
		pass
		# mover.play("idle_down")

# func _physics_process(delta):
# 	var velocity = Vector2.ZERO
# 	if Input.is_action_pressed("move_right"):
# 		velocity.x += speed
# 		# play("walk_right") # Replace with your animation name
# 	elif Input.is_action_pressed("move_left"):
# 		velocity.x -= speed
# 		# play("walk_left")
# 	else:
# 		pass
# 		# play("idle_right") # Replace with your idle animation name

# 	if Input.is_action_pressed("move_down"):
# 		velocity.y += speed
# 		# play("walk_down")
# 	elif Input.is_action_pressed("move_up"):
# 		velocity.y -= speed
# 		var tile_map = get_node("TileMap")
# 		print(tile_map)
# 		if tile_map is TileMap:
# 			print("TileMap", tile_map)
# 		# play("walk_up")
# 	else:
# 		pass
# 		# play("idle_down")
		
# 	position += velocity * delta
