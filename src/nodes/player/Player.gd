extends KinematicBody2D

enum ACTIONS { right, left }
var cur_actions = { ACTIONS.right: 0, ACTIONS.left: 0 }

export var move_acceleration = 20.0
export var max_move_velocity = 40.0
export var gravity = 9.8

var velocity = Vector2()
var acceleration = Vector2()

func _ready():
	acceleration.y = gravity
	set_physics_process(true)
	set_process_input(true)

func _physics_process(delta):
	acceleration.x = (cur_actions[ACTIONS.right] + cur_actions[ACTIONS.left]) * move_speed
	velocity += acceleration
	if(is_on_wall()):
		velocity.x = 0
	if(is_on_floor()):
		velocity.y = 0
	move_and_slide(velocity, Vector2(0, -1))

func _input(event):
	if event.is_action("ui_right"):
		if(event.pressed):
			cur_actions[ACTIONS.right] = 1
		else:
			cur_actions[ACTIONS.right] = 0
	if event.is_action("ui_left"):
		if(event.pressed):
			cur_actions[ACTIONS.left] = -1
		else:
			cur_actions[ACTIONS.left] = 0