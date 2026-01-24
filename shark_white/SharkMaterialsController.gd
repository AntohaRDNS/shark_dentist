@tool
extends MeshInstance3D


@onready var marker_3d: Marker3D = $Marker3D


func _process(delta) -> void:
	marker_3d = $Marker3D
	material_overlay.set("shader_parameter/freeze_pos", marker_3d.position)
	pass
