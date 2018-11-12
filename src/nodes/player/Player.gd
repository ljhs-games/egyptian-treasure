extends RigidBody2D

enum ACTIONS { right, left }
var cur_actions = { ACTIONS.right: 0, ACTIONS.left: 0 }

export var move_acceleration = 30.0
export var max_move_velocity = 450.0
export var jump_velocity = 400.0
export var ladder_move_velocity = 600.0

var acceleration = Vector2()
var on_ladder = false
var beginning_position = Vector2()

func _ready():
	beginning_position = global_position
	DeathBroadcaster.connect("dead", self, "_on_death")
	DeathBroadcaster.connect("reset", self, "_on_reset")
	KeyCounter.connect("new_key", self, "_on_Player_new_key")
	Settings.connect("setting_changed", self, "_on_Player_setting_changed")
	#DeathBroadcaster.emit_signal("dead")
	$PlayerLight.visible = true
	$CanvasModulate.visible = true
	set_physics_process(true)
	set_process_input(true)
	set_process(true)

func _process(delta):
	if(cur_actions[ACTIONS.right] | cur_actions[ACTIONS.left] == 0):
		$AnimatedSprite.play("default")
	else:
		if(cur_actions[ACTIONS.left]):
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walking")

func on_ladder():
	on_ladder = true
	linear_damp = 15.0
	gravity_scale = 0.0

func off_ladder():
	on_ladder = false
	linear_damp = -1
	gravity_scale = 10.0

func _physics_process(delta):
	acceleration.x = (cur_actions[ACTIONS.right] + cur_actions[ACTIONS.left]) * move_acceleration
	linear_velocity += acceleration
	linear_velocity.x = clamp(linear_velocity.x, -max_move_velocity, max_move_velocity)

func jump():
	if(on_ladder):
		linear_velocity.y = -ladder_move_velocity
	elif($RayCast2D.is_colliding()):
		#print(velocity.y)
		linear_velocity.y = -jump_velocity
		#print(velocity.y)

func down():
	if(on_ladder):
		linear_velocity.y = ladder_move_velocity

func _input(event):
	if event.is_action_pressed("down"):
		down()
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

func _on_death():
	linear_damp = 400
	gravity_scale = 0.0
	$LightTween.interpolate_property($PlayerLight, "scale", Vector2(1,1), Vector2(2,2), 0.5, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$LightTween.start()
	yield($LightTween, "tween_completed")
	$LightTween.interpolate_property($PlayerLight, "scale", Vector2(2,2), Vector2(0,0), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN, 1.0)
	$LightTween.start()
	yield($LightTween, "tween_completed")
	# now everything should be hidden...
	global_position = beginning_position
	# reset everything
	DeathBroadcaster.emit_signal("reset")

func _on_reset():
	# wait for stuff to settle
	yield(get_tree().create_timer(0.2), "timeout")
	# show self!
	linear_damp = -1
	gravity_scale = 10.0
	$LightTween.interpolate_property($PlayerLight, "scale", Vector2(0,0), Vector2(1,1), 0.5, Tween.TRANS_CUBIC,Tween.EASE_OUT, 1.0)
	yield($LightTween, "tween_completed")

func _on_Player_new_key(key_type):
	$SoundEffects.stream = preload("res://nodes/player/jungle-win.wav")
	$SoundEffects.play()

func _on_Player_setting_changed(setting_name, new_value):
	if setting_name == "audio":
		if new_value == true:
			$SoundEffects.volume_db = 0.0
		else:
			$SoundEffects.volume_db = -80.0