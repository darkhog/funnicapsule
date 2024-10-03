extends Area3D

@export var scoreValue:int=10
@export var SoundToPlay:AudioStream
var streamPlayer: AudioStreamPlayer
var touched:bool
var once:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	connect("body_entered",_on_body_entered)
	streamPlayer = AudioStreamPlayer.new()
	streamPlayer.stream = SoundToPlay
	streamPlayer.pitch_scale=randf_range(0.8,1.2)
	streamPlayer.autoplay = false
	streamPlayer.connect("finished",streamFinished)
	self.add_child(streamPlayer)
	

func streamFinished():
	if touched:
		self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body:Node3D):
	if body.name=="PlayerBody" and !streamPlayer.playing:
		if (!touched):
			Globals.score+=scoreValue
		touched=true
		streamPlayer.play(0.0);
		for child in self.get_children():
			if child is Node3D:
				child.visible=false
func _process(_delta)->void:
	self.rotate_y(-4*_delta)
	if (!once):
		#Globals.DebugPrint((sin(self.global_position.x+self.global_position.y+self.global_position.z))*1)
		#have to do it like this, because collectibles spawned with PrefabOverPath.gd will not report the correct position in _ready.
		self.rotation.y = (sin(self.global_position.x+self.global_position.y+self.global_position.z))*1
		once=true
