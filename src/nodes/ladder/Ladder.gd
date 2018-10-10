extends Area2D

func _on_Ladder_body_entered(body):
	if(body.is_in_group("player")):
		body.on_ladder()

func _on_Ladder_body_exited(body):
	if(body.is_in_group("player")):
		body.off_ladder()