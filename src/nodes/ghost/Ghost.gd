extends Node2D

enum DIRECTION { left, right }

export var move_speed = 100.0
export var bounds = Vector2(0, 1400)

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
	if(global_position.x > bounds.y):
		cur_direction = DIRECTION.left
		scale.x = -1
	if(global_position.x < bounds.x):
		cur_direction = DIRECTION.right
		scale.x = 1

func _on_Vision_body_entered(body):
	if(body.is_in_group("player")):
		DeathBroadcaster.emit_signal("dead")
		set_process(false)