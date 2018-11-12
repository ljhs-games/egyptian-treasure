extends Node2D

signal wiped_out

export (PackedScene) var boulder_pack = preload("res://nodes/boulder-wipeout/Boulder.tscn")

# times total wipeout time
var wipeout_counter = 0.0
# time between boulder drop
var boulder_counter = 0.0

func _ready():
	DeathBroadcaster.connect("dead", self, "_on_player_death")
	DeathBroadcaster.connect("reset", self, "_on_player_reset")
	set_process(false)

func _on_player_death():
	wipeout()

func _on_player_reset():
	clear_boulders()

func wipeout():
	wipeout_counter = 0.0
	boulder_counter = 0.0
	clear_boulders()
	set_process(true)

func clear_boulders():
	set_process(false)
	for n in get_children():
		if n.is_in_group("boulder"):
			n.queue_free()

func _process(delta):
	wipeout_counter += delta
	boulder_counter += delta
	if wipeout_counter >= 3.0:
		set_process(false)
		return
	if boulder_counter >= 0.01:
		var cur_boulder = boulder_pack.instance()
		add_child(cur_boulder)
		cur_boulder.global_position.x = (randi() % 640 + 60) + global_position.x
		cur_boulder.global_position.y = (-200) + global_position.y
		boulder_counter = 0.0