extends Area2D

enum DIRECTION { left=-1, right=1 }

export var move_speed = 50.0

var cur_direction = DIRECTION.right
onready var DeathBroadcaster = get_node("/root/DeathBroadcaster")
onready var right_point = get_node("../RightPoint")
onready var left_point = get_node("../LeftPoint")

func _ready():
	DeathBroadcaster.connect("dead", self, "_on_ZombieCat_dead")
	DeathBroadcaster.connect("reset", self, "_on_ZombieCat_reset")
	set_process(true)

func _process(delta):
	if global_position.x > right_point.global_position.x or global_position.x < left_point.global_position.x:
		cur_direction = cur_direction * -1
		global_scale = Vector2(global_scale.y*-1, 1)
		global_position.x += move_speed*delta*cur_direction
	global_position.x += move_speed*delta*cur_direction

func _on_ZombieCat_dead():
	set_process(false)
	$AnimatedSprite.play("dissolve")

func _on_ZombieCat_reset():
	$AnimatedSprite.play("default")
	set_process(true)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		DeathBroadcaster.emit_signal("dead")
