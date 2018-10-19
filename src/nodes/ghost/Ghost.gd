extends Node2D

enum DIRECTION { left, right }

export var move_speed = 100.0

var cur_direction = DIRECTION.right

func _ready():
	update_direction()
	set_process(true)

func _process(delta):
	update_direction()
	if(cur_direction == DIRECTION.right):
		global_position.x += move_speed*delta
	if(cur_direction == DIRECTION.left):
		global_position.x -= move_speed*delta

func update_direction():
	if(global_position.x > OS.get_real_window_size().x):
		cur_direction = DIRECTION.left
		$Sprite.flip_h = true
	if(global_position.x < 0):
		cur_direction = DIRECTION.right
		$Sprite.flip_h = false