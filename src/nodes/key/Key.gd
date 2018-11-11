tool
extends Area2D

const KEYS = preload("res://nodes/player/KeyCounter.gd").KEYS

export (KEYS) var key_type = KEYS.red setget _set_key_type

onready var sprite_node = get_node("Sprite")

func _ready():
	self.key_type = key_type

func _set_key_type(new_key_type):
	key_type = new_key_type
	if sprite_node != null:
		if key_type == KEYS.red:
			sprite_node.texture = preload("res://nodes/key/Key_Red.png")
		elif key_type == KEYS.blue:
			sprite_node.texture = preload("res://nodes/key/Key_Blue.png")
		elif key_type == KEYS.yellow:
			sprite_node.texture = preload("res://nodes/key/Key_Yellow.png")

func _on_Key_body_entered(body):
	if Engine.editor_hint:
		return
	if body.is_in_group("player"):
		get_node("/root/KeyCounter").get_key(key_type)
		queue_free()