extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = Globals.MAX_HP
	min_value = 0
	value = Globals.playerHealth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if value!=Globals.playerHealth:
		value = Globals.playerHealth
