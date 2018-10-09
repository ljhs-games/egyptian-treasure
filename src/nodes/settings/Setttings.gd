extends Node

signal setting_changed(setting_string, new_val)

var audio = true setget _set_audio

func _set_audio(new_audio):
	audio = new_audio
	emit_signal("setting_changed", "audio", new_audio)