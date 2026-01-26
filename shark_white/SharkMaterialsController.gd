@tool
class_name SharkMaterialsController
extends Node3D


@export var body: MeshInstance3D
@export var animation_tree: AnimationTree

var tween: Tween

const GROW_TIME: float = 1.0


#func _process(delta) -> void:
	#marker_3d = $Marker3D
	#body.material_overlay.set("shader_parameter/freeze_pos", marker_3d.position)
	#pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if (event.is_action_pressed("ui_action")):
			mouth_open()
		pass
	pass


func mouth_open() -> void:
	tween = get_tree().create_tween()
	tween.tween_method(func(value): animation_tree.set("parameters/mouth_open_blend/blend_amount", value), 0.0, 1.0, GROW_TIME).set_ease(Tween.EASE_IN_OUT) # tween from current value to 1
	pass


func freeze(_position_global: Vector3) -> void:
	var position_local: Vector3 = to_local(_position_global)
	body.material_overlay.set("shader_parameter/freeze_pos", position_local)
	tween = get_tree().create_tween()
	tween.tween_method(func(value): body.material_overlay.set("shader_parameter/freeze_grow", value), 0.0, 1.0, GROW_TIME).set_ease(Tween.EASE_IN) # tween from current value to 1
	pass
