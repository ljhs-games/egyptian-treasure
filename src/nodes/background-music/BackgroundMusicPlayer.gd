extends AudioStreamPlayer

func _on_setting_changed(setting, new_value):
	if(setting == "audio"):
		if(new_value == true):
			volume_db = 0.0
			#volume_db = -20.0
		else:
			volume_db = -80.0

func _ready():
	Settings.connect("setting_changed", self, "_on_setting_changed")