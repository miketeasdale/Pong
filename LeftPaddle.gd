extends Node2D

# Declare member variables here. Examples:
export var speed = 100
var direction = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	pass # Replace with function body.

func reset():
	direction = 0
	position = Vector2(24, 300)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left_move_down"):
		print("down")
		direction = 1
	elif Input.is_action_pressed("left_move_up"):
		direction = -1
		print("up")
	else:
		print("nothing")
		direction = 0
	position.y += direction * speed
