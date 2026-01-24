class_name Pickable
extends StaticBody3D


func pick()-> void:
	print("pick")
	$MeshInstance3D.get_surface_override_material(0).set("albedo_color", Color.RED)
	pass
