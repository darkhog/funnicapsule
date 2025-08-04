extends SpringArm3D
@export var rotationstrength:float = 0.01
@export var minclampX:float = -70
@export var maxclampX:float = 70
@export var maxspringlen:float = 7.5
@export var minspringlen:float = 2
@export var zoomStrength:float = 1
@export var PlayerObj:Node3D
# Called when the node enters the scene tree for the first time.
func _ready()->void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
# ##############################################################################
# NOTE FROM THE DEVELOPER: Look at this shit. Look. At.
# This. Shit. Any stupid kid could maintain it. I hate it.
# I hate it so fucking much. Why did they have to base GDScript
# off Python? Why couldn't it been Perl? You know, a language
# that actually protects your job security? Understanding your own
# code is good. It's when OTHER PEOPLE can understand your code
# the things get ugly. Because it makes you REPLACEABLE. Fuck. This. Shit.
# ##############################################################################

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta:float)->void:
	#Globals.DebugPrint(Globals.lockCamera)
	if Globals.lockCamera:
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		rotate_object_local(Vector3.UP,Input.get_last_mouse_velocity().x*delta*(rotationstrength*-1))
		rotate_object_local(Vector3.LEFT,Input.get_last_mouse_velocity().y*delta*rotationstrength)
		rotation.z = 0
		rotation_degrees.x = clamp(rotation_degrees.x,minclampX,maxclampX)
		var scrolldelta:float = 0
		if Input.is_action_just_released("CameraZoomIn"):
			scrolldelta = scrolldelta-1
		if Input.is_action_just_released("CameraZoomOut"):
			scrolldelta = scrolldelta+1
		spring_length = spring_length + (scrolldelta*delta*zoomStrength)
		spring_length = clamp(spring_length,minspringlen,maxspringlen)
	#else:
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
