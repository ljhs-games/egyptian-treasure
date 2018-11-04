extends Node2D

signal wiped_out

export (PackedScene) var boulder_pack = preload("res://nodes/boulder-wipeout/Boulder.tscn")

# times total wipeout time
var wipeout_counter = 0.0
# time between boulder drop
var boulder_counter = 0.0
var boulders = []

func _ready():
	set_process(false)
	#wipeout()

func wipeout():
	wipeout_counter = 0.0
	boulder_counter = 0.0
	clear_boulders()
	boulders = []
	set_process(true)

func clear_boulders():
	for b in boulders:
			b.queue_free()

func _process(delta):
	wipeout_counter += delta
	boulder_counter += delta
	if wipeout_counter >= 3.0:
		set_process(false)
		emit_signal("wiped_out")
		return
	if boulder_counter >= 0.01:
		var cur_boulder = boulder_pack.instance()
		add_child(cur_boulder)
		cur_boulder.global_position.x = randi() % 640 + 60
		cur_boulder.global_position.y = -200
		boulders.append(cur_boulder)
		boulder_counter = 0.0