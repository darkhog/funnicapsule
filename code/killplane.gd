extends Area3D

func _on_body_entered(body:Node3D):
	if body.name=="PlayerBody":
		body.hurtPlayer(29000000)
