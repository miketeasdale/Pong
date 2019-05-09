extends Node2D

# Declare member variables here. Examples:
var leftScore = 0
var rightScore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameTimer.set_wait_time(300)
	$GameTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Display/LeftScore.text = str(leftScore)
	$Display/RightScore.text = str(rightScore)
	var minutes : int = $GameTimer.get_time_left() as int / 60
	var seconds : int = $GameTimer.get_time_left() as int % 60
	$Display/Clock.text = str(minutes) + ":" + str(seconds)
