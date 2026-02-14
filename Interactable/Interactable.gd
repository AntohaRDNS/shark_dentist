class_name Interactable
extends StaticBody3D


enum State
{
	default,
	hovered,
	unhovered,
	grabbed,
	activated
}
var interactable_state: State = State.default

@export var mesh_instance_3d: MeshInstance3D
@onready var material: Material = (func() -> Material: return mesh_instance_3d.get_surface_override_material(0)).call()
@export var audio_stream_player: AudioStreamPlayer
var tween: Tween
const PICK_TIME: float = 0.1
var param_name_emission: StringName = "emission_energy_multiplier"
var param_name_grow: StringName = "grow_multiplier"


func _ready() -> void:
	pass


func on_hover() -> void:
	print("on_hover")
	interactable_state = State.hovered
	audio_stream_player.play()
	pass
	
	
func while_hover() -> void:
	print(".")
	pass
	

func on_unhover() -> void:		
	print("on_unhover")
	interactable_state = State.unhovered
	pass


func on_grab() -> void:
	print("on_grab")
	interactable_state = State.grabbed
	pass


func on_activate()-> void:
	print("on_activate")
	interactable_state = State.activated
	pass
