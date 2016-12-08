#################################################
# Player 
# TODO: Set player collision shape back to 16*16
# TODO: change movemnt to tilemap based


extends KinematicBody2D

var motion = Vector2()

func _ready():
	set_fixed_process(true)
	set_process_input(true)

func _fixed_process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_right"):
		motion.x = 32
	elif event.is_action_pressed("ui_left"):
		motion.x = -32
	elif event.is_action_pressed("ui_up"):
		motion.y = -32
	elif event.is_action_pressed("ui_down"):
		motion.y = 32
	
	motion = move(motion)
	
func try_move(direction):
	if (direction == "right"):
		check_if_tile_is_free()
	
