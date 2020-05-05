extends Node2D

# Declare member variables here. Examples:
signal game_over
export var gameTime = 10
var leftScore
var rightScore
var gameOver = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func waiting_start():
	leftScore = 0
	rightScore = 0
	$Display/Message.text = "Press space to start..."
	$Display/Message.visible = true

func game_start():
	leftScore = 0
	rightScore = 0
	$GameTimer.set_wait_time(gameTime)
	$GameTimer.start()
	$Display/Message.visible = false
	
func game_end():
	var winner 
	if leftScore > rightScore:
		winner = "Left Player wins!" 
	elif rightScore > leftScore:
		winner = "Right Player wins!"
	else:
		winner = "Tie!"
	$Display/Message.text = "Game Over\n" + winner
	$Display/Message.visible = true
	gameOver = true
	$MessageTimer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#warning-ignore:unused_argument
func _process(delta):
	$Display/LeftScore.text = str(leftScore)
	$Display/RightScore.text = str(rightScore)
	var minutes : int = $GameTimer.get_time_left() as int / 60
	var seconds : int = $GameTimer.get_time_left() as int % 60
	$Display/Clock.text = "%02d:%02d" % [minutes, seconds]

func _on_GameTimer_timeout():
	game_end()
	
func _on_MessageTimer_timeout():
	#print("Timer timed out.")
	$Display/Message.visible = false
	if gameOver:
		gameOver = false;
		emit_signal("game_over")
	
func _on_Ball_goal(side):
	if side == 0:
		leftScore += 1
	else:
		rightScore += 1
	
