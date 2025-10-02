extends NavigationAgent3D

var pdelta:float;
var pframe:int=0
@export var visInst:VisualInstance3D
func _ready() -> void:
	var agent: RID = get_rid()
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
	#var new_velocity: Vector3 = (get_parent() as Node3D).global_position.move_toward(get_next_path_position() * max_speed,delta)
	##new_velocity = (get_parent() as Node3D).global_position.direction_to(get_next_path_position()*max_speed)
	#if (pframe % 10 == 0):
		#Globals.DebugPrint(new_velocity)
	#(get_parent() as Node3D).global_translate(new_velocity*delta)
	
	var lerpedPosition:Vector3 = (get_parent() as Node3D).global_position
	lerpedPosition = lerpedPosition.lerp(get_next_path_position(),0.02)
	#visInst.rotation = (get_parent() as Node3D).global_position.direction_to(get_next_path_position())
	visInst.look_at(get_next_path_position(),Vector3.UP,true)
	#(get_parent() as Node3D).global_position = lerpedPosition
	(get_parent() as Node3D).global_position = (get_parent() as Node3D).global_position.move_toward(get_next_path_position(), max_speed*delta)
	#_on_velocity_computed(new_velocity)
	pass

func _on_navigation_finished() -> void:
	#Globals.DebugPrint("New navigation (NF)")
	newNavigation()

func newNavigation() -> void:
	var pos = (get_parent() as Node3D).global_position
	var navradius = (get_parent() as Node3D).get_meta("nav_radius",1.0)
	#Globals.DebugPrint(pos)
	pos.x += randf_range(-navradius,navradius)
	pos.y += randf_range(-navradius,navradius)
	pos.z += randf_range(-navradius,navradius)
	target_position = pos
	#while (not is_target_reachable()):
		#pos = (get_parent() as Node3D).global_position
		#pos.x += randf_range(-navradius,navradius)
		#pos.y += randf_range(-navradius,navradius)
		#pos.z += randf_range(-navradius,navradius)
		#target_position = pos

func _on_velocity_computed(safe_velocity: Vector3) -> void:
	#(get_parent() as Node3D).global_position =(get_parent() as Node3D).global_position.move_toward((get_parent() as Node3D).global_position + safe_velocity, pdelta * max_speed)
	(get_parent() as Node3D).global_translate(safe_velocity)

func _on_target_reached() -> void:
	#Globals.DebugPrint("New navigation (TR)")
	newNavigation()


func _on_cone_hurting_player() -> void:
	newNavigation()
