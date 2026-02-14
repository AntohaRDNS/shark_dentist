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
var param_name: StringName = "emission_energy_multiplier"


func _ready() -> void:
	pass


func on_hover() -> void:
	interactable_state = State.hovered
	pass
	
	
func while_hover() -> void:
	pass
	

func on_unhover() -> void:		
	interactable_state = State.unhovered
	pass


func on_grab() -> void:
	interactable_state = State.grabbed
	pass


func on_activate()-> void:
	#print("pick")
	interactable_state = State.activated
	pass
