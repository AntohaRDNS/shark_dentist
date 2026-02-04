class_name Interactable
extends StaticBody3D


@export var mesh_instance_3d: MeshInstance3D
@onready var material: Material = (func() -> Material: return mesh_instance_3d.get_surface_override_material(0)).call()
@export var audio_stream_player: AudioStreamPlayer
var tween: Tween
const PICK_TIME: float = 0.
var param_name: StringName = "emission_energy_multiplier"


func pick()-> void:
	mesh_instance_3d.get_surface_override_material(0).set("albedo_color", Color.RED)
	pass
	

func on_hover() -> void:
	if tween != null:
		tween.stop()
		tween = null
		
	tween = get_tree().create_tween()
	tween.tween_method(func(value): mesh_instance_3d.set_instance_shader_parameter(param_name, value), mesh_instance_3d.get_instance_shader_parameter(param_name), 1.0, PICK_TIME).set_ease(Tween.EASE_IN) # tween from current value to 1
	
	audio_stream_player.play()
	pass
	

func on_unhover() -> void:
	if tween != null:
		tween.stop()
		tween = null
		
	tween = get_tree().create_tween()
	tween.tween_method(func(value): mesh_instance_3d.set_instance_shader_parameter(param_name, value), mesh_instance_3d.get_instance_shader_parameter(param_name), 0.0, PICK_TIME).set_ease(Tween.EASE_IN) # tween from current value to 0
	pass
