class_name Interactable
extends StaticBody3D


enum InteractableState
{
	default,
	hovered,
	unhovered,
	picked
}
var interactable_state: InteractableState = InteractableState.default


@export var mesh_instance_3d: MeshInstance3D
@onready var material: Material = (func() -> Material: return mesh_instance_3d.get_surface_override_material(0)).call()
@export var audio_stream_player: AudioStreamPlayer
var tween: Tween
const PICK_TIME: float = 0.1
var param_name: StringName = "emission_energy_multiplier"

	
func on_hover() -> void:
	print("on_hover")
	#interactable_state = InteractableState.hovered
	pass
	

func on_unhover() -> void:
	print("on_unhover")
	interactable_state = InteractableState.unhovered
	pass


func pick()-> void:
	print("pick")
	interactable_state = InteractableState.picked
	pass
