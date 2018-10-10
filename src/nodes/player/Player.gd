extends RigidBody2D

enum ACTIONS { right, left }
var cur_actions = { ACTIONS.right: 0, ACTIONS.left: 0 }

export var move_acceleration = 30.0
export var max_move_velocity = 450.0
export var jump_velocity = 400.0

var acceleration = Vector2()

func _ready():
	set_physics_process(true)
	set_process_input(true)

func _physics_process(delta):
	acceleration.x = (cur_actions[ACTIONS.right] + cur_actions[ACTIONS.left]) * move_acceleration
	linear_velocity += acceleration
	linear_velocity.x = clamp(linear_velocity.x, -max_move_velocity, max_move_velocity)

func jump():
	if($RayCast2D.is_colliding()):
		#print(velocity.y)
		linear_velocity.y = -jump_velocity
		#print(velocity.y)

func _input(event):
	if event.is_action_pressed("jump"):
		jump()
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

func bring_to_zero(cur_val, difference):
	if(abs(cur_val) > abs(difference)):
		return (abs(cur_val)/cur_val)*-1*difference
	else:
		return -cur_val