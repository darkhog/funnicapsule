extends AudioStreamPlayer3D

@export var MinPitch:float = 1.0
@export var MaxPitch:float = 1.0
@export var MinDelayPlayback:float = 1.0
@export var MaxDelayPlayback:float = 5.0

var elapsedTime:float = 0
var timeUntilNextPlay = 0

func _ready() -> void:
	timeUntilNextPlay = randf_range(MinDelayPlayback,MaxDelayPlayback)

func _process(delta: float) -> void:
	elapsedTime+=delta
	if elapsedTime >= timeUntilNextPlay:
		timeUntilNextPlay = randf_range(MinDelayPlayback,MaxDelayPlayback)
		pitch_scale = randf_range(MinPitch,MaxPitch)
		elapsedTime = 0
		play()
