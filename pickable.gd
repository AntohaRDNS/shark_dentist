class_name Pickable
extends StaticBody3D

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var material: Material = (func() -> Material: return mesh_instance_3d.get_surface_override_material(0)).call()

func pick()-> void:
	print("pick")
	mesh_instance_3d.get_surface_override_material(0).set("albedo_color", Color.RED)
	pass
	
	
func on_hover() -> void:
	material.set("emission_energy_multiplier", 1.0)
	pass
	
func on_unhover() -> void:
	material.set("emission_energy_multiplier", 0.0)
	pass
