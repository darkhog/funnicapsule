extends Area3D

@export var sceneName:String
var readytochange:bool = false
func _ready() -> void:
	if not is_connected("body_entered",_on_body_entered):
		connect("body_entered",_on_body_entered)

# Called when the node enters the scene tree for the first time.
func _on_body_entered(_body:Node3D):
	readytochange = true
func _process(delta: float) -> void:
	if readytochange:
		get_tree().change_scene_to_file("res://levels/"+sceneName+".tscn")
