extends NavigationAgent3D

var pdelta:float;
var pframe:int=0
var theParent:Node3D
var aggrorange:float
var aggroed: bool = false
var navradius:float 
@export var visInst:VisualInstance3D
func _ready() -> void:
	pframe = randi_range(0,7860)
	var agent: RID = get_rid()
	theParent = (get_parent() as Node3D)
	navradius= theParent.get_meta("nav_radius",1.0)
	aggrorange = theParent.get_meta("nav_player_alert",4.0)
	target_position = (get_parent() as Node3D).global_position
	max_speed = get_parent().get_meta("ConeSpeed",4.20)
	#Globals.DebugPrint("Cone Position: "+str((get_parent() as Node3D).global_position)+" (init)")

func _physics_process(delta: float) -> void:
	pdelta =delta
	pframe+=1
	#if (pframe % 10 == 0):
		#Globals.DebugPrint("Cone Position: "+str((get_parent() as Node3D).global_position)+" pframe: "+str(pframe))
		#Globals.DebugPrint(target_position)
		#Globals.DebugPrint(get_next_path_position())
	if NavigationServer3D.map_get_iteration_id(get_navigation_map()) == 0:
		return
	if is_navigation_finished():
		return
	if ((theParent.global_position.distance_to(Globals.playerPosition)<aggrorange) && (pframe % 10==0)):
		if (!aggroed):
			newNavigation()
			aggroed=true
	if ((theParent.global_position.distance_to(Globals.playerPosition)>aggrorange) && (pframe % 10==0)):
		if (aggroed):
			newNavigation()
			aggroed=false
	#var new_velocity: Vector3 = (get_parent() as Node3D).global_position.move_toward(get_next_path_position() * max_speed,delta)
	##new_velocity = (get_parent() as Node3D).global_position.direction_to(get_next_path_position()*max_speed)
	#if (pframe % 10 == 0):
		#Globals.DebugPrint(new_velocity)
	#(get_parent() as Node3D).global_translate(new_velocity*delta)
	
	var lerpedPosition:Vector3 = theParent.global_position
	lerpedPosition = lerpedPosition.lerp(get_next_path_position(),0.02)
	#visInst.rotation = (get_parent() as Node3D).global_position.direction_to(get_next_path_position())
	visInst.look_at(get_next_path_position(),Vector3.UP,true)
	#(get_parent() as Node3D).global_position = lerpedPosition
	theParent.global_position = theParent.global_position.move_toward(get_next_path_position(), max_speed*delta)
	#_on_velocity_computed(new_velocity)
	pass

func _on_navigation_finished() -> void:
	#Globals.DebugPrint("New navigation (NF)")
	newNavigation()

func _process(delta: float) -> void:
	pass

func newNavigation() -> void:
	var pos:Vector3 = theParent.global_position
	
	if (absf(pos.distance_to(Globals.playerPosition))>aggrorange):
		pos.x += randf_range(-navradius,navradius)
		pos.y += randf_range(-navradius,navradius)
		pos.z += randf_range(-navradius,navradius)
		target_position = pos
	else:
		target_position = Globals.playerPosition

func _on_velocity_computed(safe_velocity: Vector3) -> void:
	#(get_parent() as Node3D).global_position =(get_parent() as Node3D).global_position.move_toward((get_parent() as Node3D).global_position + safe_velocity, pdelta * max_speed)
	theParent.global_translate(safe_velocity)

func _on_target_reached() -> void:
	#Globals.DebugPrint("New navigation (TR)")
	newNavigation()


func _on_cone_hurting_player() -> void:
	newNavigation()
