class_name Tooth
extends Interactable
	

func on_hover() -> void:
	super.on_hover()
	
	if tween != null:
		tween.stop()
		tween = null
		
	tween = get_tree().create_tween()
	tween.tween_method\
	(
		func(value): mesh_instance_3d.set_instance_shader_parameter(param_name_emission, value),\
		mesh_instance_3d.get_instance_shader_parameter(param_name_emission),\
		1.0,\
		PICK_TIME
	).set_ease(Tween.EASE_IN) # tween from current value to 1
	
	pass
	

func on_unhover() -> void:
	super.on_unhover()
		
	if tween != null:
		tween.stop()
		tween = null
		
	tween = get_tree().create_tween()
	tween.tween_method\
	(
		func(value): mesh_instance_3d.set_instance_shader_parameter(param_name_emission, value),\
		mesh_instance_3d.get_instance_shader_parameter(param_name_emission),\
		0.0,\
		PICK_TIME
	).set_ease(Tween.EASE_IN) # tween from current value to 0
	pass
	
	
func on_activate()-> void:
	super.on_activate()
	pass
