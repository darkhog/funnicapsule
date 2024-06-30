@tool
extends Path3D
@export var CollisionShape:PackedScene:
	set(value):
		CollisionShape = value
		is_dirty = true
@export var offset:float = 0.5:
	set(value):
		offset = value
		is_dirty = true
@export var distance_between_planks:float = 1.0:
	set(value):
		distance_between_planks = value
		is_dirty = true
var is_dirty = false
@export var multimeshinst:MultiMeshInstance3D:
	set(value):
		multimeshinst = value
		is_dirty = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dirty:
		_update_multimesh()

		is_dirty = false

func _update_multimesh():
	var cnode:Node3D
	if is_instance_valid(CollisionShape):
		cnode = get_node_or_null("Collisions")
		if is_instance_valid(cnode):
			cnode.free()
		if !is_instance_valid(cnode):
			cnode = Node3D.new()
			cnode.name = "Collisions"
			add_child(cnode)
	var path_length: float = curve.get_baked_length()
	var count = floor(path_length / distance_between_planks)
	if !is_instance_valid(multimeshinst):
		printerr("Set Multimeshinst to MultimeshInstance!")
		return
	var mm: MultiMesh = multimeshinst.multimesh
	mm.instance_count = count
	

	for i in range(0, count):
		var curve_distance = offset + distance_between_planks * i
		var pos = curve.sample_baked(curve_distance, true)

		var bas = Basis()
		
		var up = curve.sample_baked_up_vector(curve_distance, true)
		var forward = pos.direction_to(curve.sample_baked(curve_distance + 0.1, true))

		bas.y = up
		bas.x = forward.cross(up).normalized()
		bas.z = -forward
		
		var tm = Transform3D(bas, pos)
		mm.set_instance_transform(i, tm)
		if is_instance_valid(CollisionShape):
			var cs:Node3D = CollisionShape.instantiate() as Node3D
			cnode.add_child(cs)
			cs.transform = tm


func _on_curve_changed():
	is_dirty = true
