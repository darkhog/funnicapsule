@tool
extends Node
@export var openLevelArea:Area3D
@export var levelLabel:Label3D
var fcount:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	openLevelArea.sceneName = get_meta("NextLevel","Level1")
	levelLabel.text=get_meta("LevelNameHumanReadable","Next Level")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if OS.has_feature("editor"):
		fcount+=1
		if fcount % 120 == 0:
			levelLabel.text=get_meta("LevelNameHumanReadable","Next Level")
