extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = OS.is_debug_build()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
