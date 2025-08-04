extends Area3D

func _ready() -> void:
	if not is_connected("body_entered",_on_body_entered):
		connect("body_entered",_on_body_entered)

# Called when the node enters the scene tree for the first time.
func _on_body_entered(_body:Node3D):
	get_tree().reload_current_scene()
