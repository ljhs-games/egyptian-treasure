extends AnimatedSprite


func _ready():
	self.visible = false
	DeathBroadcaster.connect("dead", self, "_on_player_dead")
	#_on_player_dead()

func _on_player_dead():
	print("making visible")
	self.visible = true
	modulate.a = 1.0
	frame = 0
	play("default")

func _on_ExclamationPoint_animation_finished():
	$Tween.interpolate_property(self, @"modulate:a", 1.0, 0.0, 0.4, Tween.TRANS_CUBIC,Tween.EASE_OUT, 0.5)
	$Tween.start()
	yield($Tween, "tween_completed")
	self.visible = false