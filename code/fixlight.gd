extends Node

var we:WorldEnvironment
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	we = get_node("WorldEnvironment") as WorldEnvironment
	we.environment.sdfgi_enabled = false
	await get_tree().process_frame #waiting for a single frame before reenabling
	we.environment.sdfgi_enabled = true

