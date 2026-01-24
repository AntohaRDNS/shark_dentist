class_name Pickable
extends StaticBody3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var material: Material = (func() -> Material: return mesh_instance_3d.get_surface_override_material(0)).call()
var tween: Tween


func pick()-> void:
	print("pick")
	mesh_instance_3d.get_surface_override_material(0).set("albedo_color", Color.RED)
	pass
	

func on_hover() -> void:
	
	if tween != null:
		tween.stop()
		tween = null

	tween = get_tree().create_tween()
	tween.tween_method(func(value): material.set("emission_energy_multiplier", value), material.get("emission_energy_multiplier"), 1.0, 0.25).set_ease(Tween.EASE_IN) # tween from current value to 1
	pass
	

func on_unhover() -> void:
	
	if tween != null:
		tween.stop()
		tween = null
		
	tween = get_tree().create_tween()
	tween.tween_method(func(value): material.set("emission_energy_multiplier", value), material.get("emission_energy_multiplier"), 0.0, 0.25).set_ease(Tween.EASE_IN) # tween from current value to 0
	pass
