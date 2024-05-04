extends Area3D

@export var sceneName:String
# Called when the node enters the scene tree for the first time.
func _on_body_entered(body:Node3D):
	get_tree().change_scene_to_file("res://levels/"+sceneName+".tscn")
