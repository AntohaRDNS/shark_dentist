@tool
extends Node3D


@export var marker_3d: Marker3D
@export var body: MeshInstance3D


func _process(delta) -> void:
	marker_3d = $Marker3D
	body.material_overlay.set("shader_parameter/freeze_pos", marker_3d.position)
	pass
