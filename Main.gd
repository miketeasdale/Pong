extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum {WAITING_START, WAITING_SERVE, PLAYING, GOAL, GAME_OVER}
var gameState
var serveSide
var ball_offset

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	ball_offset = $Ball.ballOffset + $LeftPaddle.paddleOffset + 2
	# print("Main.ready: Ball offset: " + str(ball_offset))
	game_wait()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#warning-ignore:unused_argument
func _process(delta):
	if gameState == WAITING_SERVE:
		place_ball()

func _unhandled_input(event):
	if event.is_action_released("serve"):
		print("Main._input: Space pressed.")
		if gameState == WAITING_START:
			game_start()
		elif gameState == WAITING_SERVE:
			serve()

func place_ball():
	if serveSide == $Ball.Side.LEFT:
		$Ball.position.x = $LeftPaddle.position.x + ball_offset
		$Ball.position.y = $LeftPaddle.position.y
	else:
		$Ball.position.x = $RightPaddle.position.x - ball_offset
		$Ball.position.y = $RightPaddle.position.y
	
func game_wait():
	gameState = WAITING_START
	$Ball.visible = false;
	$LeftPaddle.reset()
	$RightPaddle.reset()
	# place_ball()
	$HUD.waiting_start()

func game_start():
	gameState = WAITING_SERVE
	serveSide = $Ball.Side.LEFT if randi() % 2 == 0 else $Ball.Side.RIGHT
	place_ball()
	$Ball.visible = true;
	# print("Main.game_start: " + str($Ball.position))
	$HUD.game_start()
	$LeftPaddle.start()
	$RightPaddle.start()

func serve():
	$Ball.serve(serveSide)
	gameState = PLAYING

func _on_Ball_goal(side):
	gameState = WAITING_SERVE
	serveSide = side

func _on_HUD_game_over():
	$Ball._ready()
	game_wait()
