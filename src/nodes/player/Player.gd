extends KinematicBody2D

enum ACTIONS { right, left }
var cur_actions = { ACTIONS.right: 0, ACTIONS.left: 0 }

export var move_speed = 300.0
export var gravity = 9.8

var velocity = Vector2()
var acceleration = Vector2()

func _ready():
	acceleration.y = gravity
	set_physics_process(true)
	set_process_input(true)

func _physics_process(delta):
	move_and_slide(velocity, Vector2(0, -1))
	if(is_on_floor()):
		velocity.y = 0
	velocity += acceleration