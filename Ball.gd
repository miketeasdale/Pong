extends Node2D

# Declare member variables here. Examples:
var speed
var direction
enum Side {LEFT, RIGHT}
const START_SPEED = 5
signal goal(side)
var ballOffset

# Called when the node enters the scene tree for the first time.
func _ready():
	ballOffset = $BallArea/CollisionShape2D.shape.get_radius()
	direction = Vector2(0, 0)
	speed = START_SPEED
	var screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#warning-ignore:unused_argument
func _process(delta):
	# print("Ball._process: " + str(position))
	position = position + (direction * speed)

func _on_BallArea_area_entered(area):
	var name = area.get_name();
	print("$Ball._on_BallArea_area_entered: " + str(position))
	# print("Area: " + area.get_name())
	if name == "TopWallArea" or name == "BottomWallArea":
		reflectY()
	elif name == "LeftGoal" or name == "RightGoal":
		emit_signal("goal", Side.LEFT if name == "RightGoal" else Side.RIGHT)
	else:
		reflectX()

func serve(side):
	if side == Side.LEFT:
		direction = Vector2(1, 0)
	else:
		direction = Vector2(-1, 0)
	speed = START_SPEED


func reflectX():
	direction.x *= -1
	vary_speed()
	vary_direction()
	#print("New direction: " + str(direction))

func reflectY():
	#print("ReflectY - Current direction: " + str(direction))
	direction.y *= -1
	vary_speed()
	vary_direction()
	#print("New direction: " + str(direction))

func vary_speed():
	speed += get_variation() * 2
	speed = clamp(speed, START_SPEED, 20)

func vary_direction():
	var oldSign = sign(direction.x)
	direction.x += get_variation() / 10.0
	if sign(direction.x) != oldSign:
		direction.x *= -1
	oldSign = sign(direction.y)
	direction.y += get_variation() / 10.0
	if sign(direction.y) != oldSign:
		direction.y *= -1
	direction = direction.normalized()

func get_variation():
	var number = randi() % 10
	var value
	if number == 0:
		value = -2
	elif number >= 1 and number <= 2:
		value = -1
	elif number >= 3 and number <= 6:
		value = 0
	elif number >= 7 and number <= 8:
		value = 1
	else:
		value = 2
	return value
