extends DirectionalLight3D

var fixlight:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shadow_enabled=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !(fixlight):
		shadow_enabled=true
		fixlight=true
