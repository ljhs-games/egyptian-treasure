# is a tool script because key needs acces to function while tool
tool
extends Node

enum KEYS { red, blue, yellow }

signal new_key(key_type)

var got_keys = { KEYS.red: false, KEYS.blue: false, KEYS.yellow: false }

func has_all_keys():
	return got_keys[KEYS.red] and got_keys[KEYS.blue] and got_keys[KEYS.yellow]

func get_key(key_type):
	if got_keys[key_type] == false:
		got_keys[key_type] = true
		emit_signal("new_key", key_type)
		return
	printerr("Duplicate key gotten")

func key_string(key_type):
	if key_type == KEYS.red:
		return "Red"
	elif key_type == KEYS.blue:
		return "Blue"
	elif key_type == KEYS.yellow:
		return "Yellow"