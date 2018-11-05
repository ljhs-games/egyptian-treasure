extends Node2D

enum DIRECTION { left, right }

export var move_speed = 150.0
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
	# disable collision
	$Vision/CollisionPolygon2D.disabled = true
	# stop moving
	set_process(false)
	# dim vision light
	var dim_tween = Tween.new()
	add_child(dim_tween)
	dim_tween.interpolate_property($Light2D, "energy", 1.0, 0.0, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	dim_tween.start()
	yield(dim_tween, "tween_completed")
	dim_tween.queue_free()

func _on_player_reset():
	# reset position
	global_position = beginning_position
	var brighten_tween = Tween.new()
	add_child(brighten_tween)
	brighten_tween.interpolate_property($Light2D, "energy", 0.0, 1.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	brighten_tween.start()
	yield(brighten_tween, "tween_completed")
	brighten_tween.queue_free()
	# reenable gaze area
	$Vision/CollisionPolygon2D.disabled = false
	# start moving
	set_process(true)