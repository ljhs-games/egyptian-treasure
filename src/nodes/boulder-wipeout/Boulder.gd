extends RigidBody2D

enum rock_type { ONE=1, TWO=2, THREE=3 }
var static_timer = 0.0

func _ready():
	randomize()
	set_rock_type(randi() % 3 + 1)
	var physics_layer = randi() % 2 + 1
	set_collision_layer_bit(physics_layer, true)
	set_collision_mask_bit(physics_layer, true)
	set_process(true)

func _process(delta):
	static_timer += delta
	if static_timer >= 1.5:
		mode = RigidBody2D.MODE_STATIC
		set_process(false)

func set_rock_type(in_rock_type):
	if in_rock_type == rock_type.ONE:
		$Sprite.texture = preload("res://nodes/boulder-wipeout/Rock_1.png")
		add_child(preload("res://nodes/boulder-wipeout/Rock1CollisionShape.tscn").instance())
	elif in_rock_type == rock_type.TWO:
		$Sprite.texture = preload("res://nodes/boulder-wipeout/Rock_2.png")
		add_child(preload("res://nodes/boulder-wipeout/Rock2CollisionShape.tscn").instance())
	elif in_rock_type == rock_type.THREE:
		$Sprite.texture = preload("res://nodes/boulder-wipeout/Rock_3.png")
		add_child(preload("res://nodes/boulder-wipeout/Rock3CollisionShape.tscn").instance())