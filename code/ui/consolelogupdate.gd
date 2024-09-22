extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if text!=Globals.consolelog:
		text=Globals.consolelog
	if len(Globals.consolelog)>8192:
		Globals.consolelog = Globals.consolelog.substr(len(Globals.consolelog)-8192)
