@tool
extends Path3D
@export var Prefab:PackedScene:
	set(value):
		Prefab = value
		is_dirty = true
@export var offset:float = 0.5:
	set(value):
		offset = value
		is_dirty = true
@export var distance_between_prefabs:float = 1.0:
	set(value):
		distance_between_prefabs = value
		is_dirty = true
var is_dirty = false
@export var rotatePrefabAlongPath:bool=false:
	set(value):
		rotatePrefabAlongPath = value
		is_dirty = true
@export var rotationIfNotRotating:Vector3 = Vector3(0,0,0): #only used if Rotate Along Prefab Along Path is false
	set(value):
		rotationIfNotRotating = value
		is_dirty = true 
# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("curve_changed",_on_curve_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dirty:
		_update_multimesh()

		is_dirty = false

func _update_multimesh():
	var cnode:Node3D
	if is_instance_valid(Prefab):
		cnode = get_node_or_null("Prefabs")
		if is_instance_valid(cnode):
			cnode.free()
		if !is_instance_valid(cnode):
			cnode = Node3D.new()
			cnode.name = "Prefabs"
			add_child(cnode)
	var path_length: float = curve.get_baked_length()
	var count :int= floor(path_length / distance_between_prefabs)
	for i in range(0, count):
		var curve_distance := offset + distance_between_prefabs * i
		var pos := curve.sample_baked(curve_distance, true)

		var bas := Basis()
		
		var up := curve.sample_baked_up_vector(curve_distance, true)
		var forward := pos.direction_to(curve.sample_baked(curve_distance + 0.1, true))
		if rotatePrefabAlongPath:
			bas.y = up
			bas.x = forward.cross(up).normalized()
			bas.z = -forward
		else:
			bas = Basis.from_euler(rotationIfNotRotating)
			
		
		var tm := Transform3D(bas, pos)
		if is_instance_valid(Prefab):
			var pf:Node3D = Prefab.instantiate() #as Node3D
			cnode.add_child(pf)
			pf.transform = tm


func _on_curve_changed():
	is_dirty = true
