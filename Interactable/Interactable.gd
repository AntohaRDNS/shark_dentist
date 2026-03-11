class_name Interactable
extends Node3D


enum State
{
	default,
	hovered,
	unhovered,
	grabbed
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
	unique_name_in_owner = true # access by % sintaxis
	owner.add_to_group("Interactable")
	pass


func on_hover() -> void:
	print("on_hover")
	interactable_state = State.hovered
	audio_stream_player.play()
	
	if tween != null:
		tween.stop()
		tween = null
		
	tween = get_tree().create_tween()
	tween.tween_method\
	(
		func(value): mesh_instance_3d.set_instance_shader_parameter(param_name_grow, value),\
		mesh_instance_3d.get_instance_shader_parameter(param_name_grow),\
		1.0,\
		PICK_TIME
	).set_ease(Tween.EASE_IN) # tween from current value to 1
	pass
	
	
func while_hover() -> void:
	print(".")
	pass
	

func on_unhover() -> void:		
	print("on_unhover")
	interactable_state = State.unhovered
	
	if tween != null:
		tween.stop()
		tween = null
		
	tween = get_tree().create_tween()
	tween.tween_method\
	(
		func(value): mesh_instance_3d.set_instance_shader_parameter(param_name_grow, value),\
		mesh_instance_3d.get_instance_shader_parameter(param_name_grow),\
		0.0,\
		PICK_TIME
	).set_ease(Tween.EASE_IN) # tween from current value to 0
	pass
