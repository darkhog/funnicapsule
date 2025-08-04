extends CanvasLayer

var frame:int = 0;
var canAddLife:bool = true
var wasPressedBefore:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = OS.is_debug_build()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Input.is_key_pressed(KEY_MINUS) and canAddLife):
		Globals.playerLives+=1
	
	frame +=1
	canAddLife = frame % 8 == 0 and OS.is_debug_build()
