extends Area2D

func _ready():
	Settings.connect("setting_changed", self, "_on_setting_changed")

func _on_setting_changed(setting, new_value):
	if(setting == "audio"):
		if(new_value == true):
			$DoorSoundEffects.volume_db = 0.0
		else:
			$DoorSoundEffects.volume_db = -80.0

func _on_ExitDoor_body_entered(body):
	if body.is_in_group("player"):
		if KeyCounter.has_all_keys():
			EndBroadcaster.emit_signal("game_end")
		else:
			$DoorSoundEffects.stream = preload("res://nodes/exit-door/door-jiggle.wav")
			$DoorSoundEffects.play()