extends RayCast3D


var interactable: Interactable 


func _physics_process(delta: float) -> void:
	
	if is_colliding():
		
		var col = get_collider()
		
		if Input.is_action_just_pressed("ui_action"):
			var t = col.owner
			if t is SharkMaterialsController:
				var col_point: Vector3 = get_collision_point()
				t.freeze(col_point)
			pass
		
		
		# if col is old Pickable
		if interactable == col: 
			pass
		
		# if col is new Pickable
		elif col is Interactable:
			#if interactable != null:
				#interactable.on_unhover()
			interactable = col
			interactable.on_hover()
		
		# if col not Pickable release old Pickable
		elif interactable != null:
			interactable.on_unhover()
			interactable = null

	# if not col release old Pickable
	elif interactable != null:
		interactable.on_unhover()
		interactable = null
