extends Label

var interScore:int=-1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if interScore!=Globals.score:
		interScore=Globals.score
		self.text="Score: "+str(interScore)
