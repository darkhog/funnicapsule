extends PathFollow3D

@export var speed:float = 1
var realspeed:float
#@export var AnimatableBodyOnPath:AnimatableBody3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	realspeed = speed/(self.get_parent() as Path3D).curve.get_baked_length()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	progress_ratio+=realspeed*delta
	
	
