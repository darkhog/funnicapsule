extends Area3D

@export var scoreValue:int=10
@export var SoundToPlay:AudioStream
@export var visualInstance:Node3D
var streamPlayer: AudioStreamPlayer
var touched:bool
var curframe:int
var once:bool=false
var distToPlayer:float=0
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
	if distToPlayer==0 or curframe%15==0:
		distToPlayer=self.global_position.distance_to(Globals.playerPosition)
	if distToPlayer<40:
		visualInstance.rotate_y(-4*_delta)
	elif curframe % 8 ==0:
		visualInstance.rotate_y((-4*_delta)*8)
	if (!once):
		#have to do it like this, because collectibles spawned with PrefabOverPath.gd 
		#will not report the correct position in _ready.
		visualInstance.rotation.y = (sin(visualInstance.global_position.x+visualInstance.global_position.y+visualInstance.global_position.z))*1
		once=true
	
	curframe+=1
