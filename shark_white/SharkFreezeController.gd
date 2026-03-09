class_name SharkFreezeController
extends Node3D

var body: MeshInstance3D 
var freeze_grow_duration: float = 2.0
var tween: Tween


func _ready() -> void:
	body = $"../rig_deform/Skeleton3D/body"
	

func freeze(_position_world: Vector3) -> void:
	var position_local: Vector3 = body.to_local(_position_world)
	var material_freeze: Material = body.mesh.surface_get_material(0).next_pass.next_pass
	material_freeze.set("shader_parameter/freeze_pos", position_local)
	var tween = get_tree().create_tween()
	tween.tween_method(func(value): material_freeze.set("shader_parameter/freeze_grow", value), 0.0, 1.0, freeze_grow_duration).set_ease(Tween.EASE_IN_OUT) # tween from current value to 0	
	pass	
