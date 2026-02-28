class_name Tool
extends Interactable


func _ready() -> void:
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


func on_grab(_target: Node3D) -> void:
	print("on_grab")
	interactable_state = State.grabbed
	
	position = _target.position
	reparent(_target, false)

	pass
	

#func on_release() -> void:
	#freeze = false
	#reparent(get_tree().get_root(), true)
	#pass


func on_activate()-> void:
	print("on_activate")
	interactable_state = State.activated
	pass
