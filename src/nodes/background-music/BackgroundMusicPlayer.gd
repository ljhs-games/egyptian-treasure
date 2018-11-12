extends AudioStreamPlayer

func _on_setting_changed(setting, new_value):
	if(setting == "audio"):
		if(new_value == true):
			volume_db = 0.0
			#volume_db = -20.0
		else:
			volume_db = -80.0

func _on_BackgroundMusicPlayer_dead():
	if Settings.get_setting("audio") == true:
		$VolumeTween.remove_all()
		$VolumeTween.interpolate_property(self, "volume_db", 0.0, -40.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$VolumeTween.start()

func _on_BackgroundMusicPlayer_reset():
	if Settings.get_setting("audio") == true:
		$VolumeTween.remove_all()
		$VolumeTween.interpolate_property(self, "volume_db", -40.0, 0.0, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$VolumeTween.start()

func _ready():
	Settings.connect("setting_changed", self, "_on_setting_changed")
	DeathBroadcaster.connect("dead", self, "_on_BackgroundMusicPlayer_dead")
	DeathBroadcaster.connect("reset", self, "_on_BackgroundMusicPlayer_reset")