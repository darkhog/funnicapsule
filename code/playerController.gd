extends RigidBody3D
@export var onGroundShape:ShapeCast3D
@export var moveForce:float=7
@export var jumpForce:float=6.66
var onGround:bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# fucking gdscript can't fucking convert the fucking bools to the fucking strings
# what the actual fuck were they thinking I can't even. I am not using string
# formatter for fucking simple debug messages. Fuck.

func boolToString (b:bool):
	if b:
		return "true"
	else:
		return "false"

func _physics_process(delta):
	#basic ground check
	onGround = !onGroundShape.collision_result.is_empty()
	#checking ground normal to ensure we can jump and it's not a fake signal from
	#a wall or something.
	if onGround:
		onGround = onGround && (onGroundShape.get_collision_normal(0).y>0.5)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass