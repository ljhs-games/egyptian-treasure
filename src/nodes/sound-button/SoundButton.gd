extends Button

export var on_color = Color()
export var off_color = Color()

func _ready():
	Settings.connect("setting_changed", self, "_on_setting_changed")
	update_color()

func _on_setting_changed(setting, new_value):
	if(setting == "audio"):
		update_color()

func update_color():
	if(Settings.audio):
		set_color(on_color)
	else:
		set_color(off_color)

func set_color(new_color):
	add_color_override("font_color", new_color)
	add_color_override("font_color_pressed", new_color)
	add_color_override("font_color_hover", new_color)
	add_color_override("font_color_disabled", new_color)

func _on_SoundButton_pressed():
	Settings.audio = !Settings.audio