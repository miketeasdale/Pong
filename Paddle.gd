extends Node2D

# Declare member variables here. Examples:
enum State{PLAYING, NOT_PLAYING}
enum Side{LEFT, RIGHT}
export (Side) var this_side
export var speed = 10
const X_INSET = 24
var direction = 0
var screenSize
var paddleOffset
var state

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size
	paddleOffset = $PaddleArea/CollisionShape2D.shape.extents.x
	print(str(this_side) + " Paddle offset: " + str(paddleOffset))
	waiting_start()

func reset():
	direction = 0
	position = Vector2(X_INSET, 300) if this_side == Side.LEFT else Vector2(screenSize.x - X_INSET, 300)

func waiting_start():
	state = State.NOT_PLAYING

func start():
	state = State.PLAYING

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == State.PLAYING:
		if this_side == Side.LEFT:
			if Input.is_action_pressed("left_move_down"):
				direction = 1
			elif Input.is_action_pressed("left_move_up"):
				direction = -1
			else:
				direction = 0
		if this_side == Side.RIGHT:
			if Input.is_action_pressed("right_move_down"):
				direction = 1
			elif Input.is_action_pressed("right_move_up"):
				direction = -1
			else:
				direction = 0
		position.y += direction * speed
		position.y = clamp(position.y, 58, screenSize.y - 58) 
