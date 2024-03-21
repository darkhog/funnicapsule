extends RigidBody3D
@export var onGroundShape:ShapeCast3D
@export var moveForce:float=7
@export var jumpForce:float=3.5
@export var PlayerDampWhenNoInput:float = 12;
@export var CamNode:Node3D
@export var PlayerVisual:Node3D
@export var ExtraJumpsZeroBased:int = 1
var InternalJumpCount:int
var onGround:bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
	# inputting the movement.
	
	if Input.is_action_pressed("forward"):
		var fvec = Vector3(-moveForce,0,0)
		fvec = fvec.rotated(Vector3(0,1,0),deg_to_rad(CamNode.global_rotation_degrees.y+270))
		apply_force(fvec)
		PlayerVisual.global_rotation_degrees.y = CamNode.global_rotation_degrees.y+180
	if Input.is_action_pressed("backward"):
		var fvec = Vector3(moveForce,0,0)
		fvec = fvec.rotated(Vector3(0,1,0),deg_to_rad(CamNode.global_rotation_degrees.y+270))
		apply_force(fvec)
		PlayerVisual.global_rotation_degrees.y = CamNode.global_rotation_degrees.y
	if Input.is_action_pressed("left"):
		var fvec = Vector3(0,0,moveForce)
		fvec = fvec.rotated(Vector3(0,1,0),deg_to_rad(CamNode.global_rotation_degrees.y+270))
		apply_force(fvec)
		PlayerVisual.global_rotation_degrees.y = CamNode.global_rotation_degrees.y+270
	if Input.is_action_pressed("right"):
		var fvec = Vector3(0,0,-moveForce)
		fvec = fvec.rotated(Vector3(0,1,0),deg_to_rad(CamNode.global_rotation_degrees.y+270))
		apply_force(fvec)
		PlayerVisual.global_rotation_degrees.y = CamNode.global_rotation_degrees.y+90
	# Jumpy McJump
	if onGround:
		InternalJumpCount = ExtraJumpsZeroBased
		if Input.is_action_just_pressed("jump"):
			apply_impulse(Vector3(0,jumpForce,0))
	#multijump
	if !onGround && InternalJumpCount>0:
		if Input.is_action_just_pressed("jump"):
			InternalJumpCount-=1
			apply_impulse(Vector3(0,jumpForce,0))
	#setting the dampening.
	if (onGround) && !(Input.is_action_pressed("jump")) && !(Input.is_action_pressed("left")) && !(Input.is_action_pressed("right")) && !(Input.is_action_pressed("forward")) && !(Input.is_action_pressed("backward")):
		linear_damp = PlayerDampWhenNoInput
	else:
		linear_damp = ProjectSettings.get_setting("physics/3d/default_linear_damp",0.1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
