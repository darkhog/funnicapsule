extends WorldEnvironment

@export var SpeedX:float=0
@export var SpeedY:float=0
@export var SpeedZ:float=0
var skymaterial:ProceduralSkyMaterial
var noisetex:NoiseTexture2D
var fnoise:FastNoiseLite
func _ready()->void:
	skymaterial = environment.sky.sky_material as ProceduralSkyMaterial
	noisetex = skymaterial.sky_cover as NoiseTexture2D
	fnoise = noisetex.noise as FastNoiseLite

func _process(delta: float)->void:
	fnoise.offset.x += delta * SpeedX
	fnoise.offset.y += delta * SpeedY
	fnoise.offset.z += delta * SpeedZ
