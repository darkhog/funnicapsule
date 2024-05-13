extends Area3D


# Called when the node enters the scene tree for the first time.
func _on_body_entered(_body:Node3D):
	get_tree().quit(0)
