extends Area3D

@export var hurtAmount:float=5

func _on_body_entered(body:Node3D):
	if body.name=="PlayerBody":
		body.hurtPlayer(hurtAmount)
