extends MeshInstance3D

@export var material_instance:int = 0

func _ready() -> void:
	var mat:StandardMaterial3D = mesh.surface_get_material(material_instance).duplicate(true)
	mat.albedo_color = Color.from_hsv(randf_range(0.0,1.0),1.0,1.0,1.0)
	mesh.surface_set_material(material_instance,mat)
