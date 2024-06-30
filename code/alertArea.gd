extends Area3D

@export var title:String=""
@export var text:String=""

func _ready() -> void:
	connect("body_entered",_on_body_entered)

func _on_body_entered(body:Node3D):
	if body.name=="PlayerBody":
		Globals.lockCamera=false
		await get_tree().process_frame
		await get_tree().process_frame
		await get_tree().process_frame
		OS.alert(text,title)
		Globals.lockCamera=true
		self.queue_free()
