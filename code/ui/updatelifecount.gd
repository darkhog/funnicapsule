extends TextureRect

var curframe:int=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updatelives()

func updatelives():
	size.x = Globals.playerLives*texture.get_width()
	if Globals.playerLives<=0:
		visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	curframe+=1
	if curframe % 5 == 0:
		updatelives()
