extends Area3D

@export var DeleteOnPlayback:bool
@export var SoundToPlay:AudioStream
var streamPlayer: AudioStreamPlayer
var touched:bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered",_on_body_entered)
	streamPlayer = AudioStreamPlayer.new()
	streamPlayer.stream = SoundToPlay
	streamPlayer.autoplay = false
	streamPlayer.connect("finished",streamFinished)
	self.add_child(streamPlayer)

func streamFinished():
	if DeleteOnPlayback and touched:
		self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body:Node3D):
	if body.name=="PlayerBody" and !streamPlayer.playing:
		touched=true
		streamPlayer.play(0.0);
