@tool
extends Node3D
@export var Prefab:PackedScene:
	set(value):
		Prefab = value
		is_dirty = true
@export var CuboidDimensions:Vector3i= Vector3i(1,1,1):
	set(value):
		CuboidDimensions = value
		if CuboidDimensions.x<1: CuboidDimensions.x=1
		if CuboidDimensions.y<1: CuboidDimensions.y=1
		if CuboidDimensions.z<1: CuboidDimensions.z=1
		is_dirty = true
@export var distance_between_prefabs:float = 1.0:
	set(value):
		distance_between_prefabs = abs(value)
		is_dirty = true
var is_dirty:bool=true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (is_dirty):
		updatePrefabCuboid()
		is_dirty=false

func updatePrefabCuboid():
	var cnode:Node3D
	if is_instance_valid(Prefab):
		cnode = get_node_or_null("Prefabs")
		if is_instance_valid(cnode):
			cnode.free()
		if !is_instance_valid(cnode):
			cnode = Node3D.new()
			cnode.name = "Prefabs"
			add_child(cnode)
		else:
			return
	
	#var SpawnNextAt:Vector3 = Vector3.ZERO
	for cx in range(0,CuboidDimensions.x):
		for cy in range(0,CuboidDimensions.y):
			for cz in range(0,CuboidDimensions.z):
				var pf:Node3D = Prefab.instantiate() #as Node3D
				cnode.add_child(pf)
				pf.position.x = cx*distance_between_prefabs
				pf.position.y = cy*distance_between_prefabs
				pf.position.z = cz*distance_between_prefabs
			
		
