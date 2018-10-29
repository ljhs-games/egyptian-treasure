extends AnimatedSprite


func _ready():
	self.visible = false
	DeathBroadcaster.connect("dead", self, "_on_player_dead")
	#_on_player_dead()

func _on_player_dead():
	self.visible = true
	play("default")

func _on_ExclamationPoint_animation_finished():
	$Tween.interpolate_property(self, @"modulate:a", 1.0, 0.0, 0.4, Tween.TRANS_CUBIC,Tween.EASE_OUT, 0.5)
	$Tween.start()