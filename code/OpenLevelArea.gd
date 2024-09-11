extends Area3D

@export var sceneName:String
func _ready() -> void:
	connect("body_entered",_on_body_entered)

# Called when the node enters the scene tree for the first time.
func _on_body_entered(_body:Node3D):
	get_tree().change_scene_to_file("res://levels/"+sceneName+".tscn")
