extends Node2D

# Declare member variables here. Examples:
var location = Vector2()
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reflectX():
	velocity.x *= -1
	
func reflectY():
	velocity.y *= -1