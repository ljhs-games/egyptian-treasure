extends Node2D

enum DIRECTION { left, right }

export var move_speed = 300.0
export var bounds = Vector2(0, 1400)

var cur_direction = DIRECTION.right
var beginning_position = Vector2()

func _ready():
	beginning_position = global_position
	DeathBroadcaster.connect("dead", self, "_on_player_death")
	DeathBroadcaster.connect("reset", self, "_on_player_reset")
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

func _on_player_death():
	set_process(false)
	var dim_tween = Tween.new()
	add_child(dim_tween)
	dim_tween.interpolate_property($Light2D, "energy", 1.0, 0.0, 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	dim_tween.start()
	yield(dim_tween, "tween_completed")
	dim_tween.queue_free()

func _on_player_reset():
	global_position = beginning_position
	$Light2D.energy = 1.0
	set_process(true)