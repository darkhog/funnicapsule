extends RigidBody3D
@export var onGroundShape:ShapeCast3D
@export var moveForce:float=7
@export var jumpForce:float=3.5
@export var GroundDampeningFactor:float = 4;
@export var CamNode:Node3D
@export var PlayerVisual:Node3D
@export var ExtraJumpsZeroBased:int = 1
@export var DeathAudioPlayer:AudioStreamPlayer
@export var DeathSound:AudioStream
@export var JumpSound:AudioStream
@export var DblJumpSound:AudioStream
@export var ShootSound:AudioStream
var InternalJumpCount:int
var onGround:bool = true
var scheduleDeath:bool=false
var hasRecentlyMoved:bool=false
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

func applyPlayerForces(mforce:Vector3,visualAngleAdjustment:float):
	var fvec = mforce.rotated(Vector3(0,1,0),deg_to_rad(CamNode.global_rotation_degrees.y+270))
	apply_force(fvec)
	PlayerVisual.global_rotation_degrees.y = CamNode.global_rotation_degrees.y+visualAngleAdjustment
	hasRecentlyMoved = true

func movement_handle():
	if !(onGround):
		hasRecentlyMoved = true
	if scheduleDeath:
		if DeathAudioPlayer.get_playback_position()>0.09:
			freeze=true
		return
	if Input.is_action_pressed("forward"):
		applyPlayerForces(Vector3(-moveForce,0,0),180)
	if Input.is_action_pressed("backward"):
		applyPlayerForces(Vector3(moveForce,0,0),0)
	if Input.is_action_pressed("left"):
		applyPlayerForces(Vector3(0,0,moveForce),270)
		hasRecentlyMoved = true
	if Input.is_action_pressed("right"):
		applyPlayerForces(Vector3(0,0,-moveForce),90)
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
	

func _physics_process(_delta):
	#basic ground check
	onGround = !onGroundShape.collision_result.is_empty()
	#checking ground normal to ensure we can jump and it's not a fake signal from
	#a wall or something.
	if onGround:
		onGround = onGround && (onGroundShape.get_collision_normal(0).y>0.7)
	# inputting the movement.
	movement_handle()
	
	
	#setting the dampening.
	if (hasRecentlyMoved) && (onGround) && !(Input.is_action_pressed("jump")) && !(Input.is_action_pressed("left")) && !(Input.is_action_pressed("right")) && !(Input.is_action_pressed("forward")) && !(Input.is_action_pressed("backward")):
		set_axis_velocity(Vector3(linear_velocity.x/GroundDampeningFactor,linear_velocity.y,linear_velocity.z/GroundDampeningFactor))
		hasRecentlyMoved = false
		
	#else:
		#linear_damp = ProjectSettings.get_setting("physics/3d/default_linear_damp",0.1)
func hurtPlayer(amount:float):
	Globals.playerHealth-=amount
	if Globals.playerHealth<=0:
		die()
	
func die():
	if DeathAudioPlayer!=null && DeathSound!=null:
		DeathAudioPlayer.stream = DeathSound
		DeathAudioPlayer.play()
		scheduleDeath = true
		Globals.lockCamera = false
	else:
		respawn()
#handles resetting the player health and decreasing lives.
func respawn():
	Globals.playerHealth=100
	Globals.playerLives-=1
	if Globals.playerLives<0:
		GameOver()
	else:
		Globals.lockCamera=true
		get_tree().reload_current_scene()
#Game Over, man. Game over.
func GameOver():
	
	Globals.lockCamera = true
	get_tree().change_scene_to_file("res://scenes/GameOver.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if scheduleDeath:
		if !DeathAudioPlayer.playing:
			respawn()
