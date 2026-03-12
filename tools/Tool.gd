class_name Tool
extends Area3D

enum State
{
	default,
	grabbed,
	used
}
var tool_state: State = State.default

@export var placeholder: Node3D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	pass
	

func on_grab(_target: Node3D) -> void:
	print("on_grab")
	audio_stream_player.play()
	tool_state = State.grabbed
	position = _target.position
	rotation = _target.rotation
	reparent(_target, false)
	pass


func on_release() -> void: # return to placeholder
	print("on_release")
	tool_state = State.default
	position = Vector3.ZERO
	rotation = Vector3.ZERO
	reparent(placeholder, false)
	pass


func on_use()-> void:
	print("on_use")
	tool_state = State.used
	pass
	
	
func while_use() -> void:
	print("while_use")
	tool_state = State.used
	pass


func on_unuse() -> void:
	print("on_unuse")
	tool_state = State.grabbed
	pass
	
