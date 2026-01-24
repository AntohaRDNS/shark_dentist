extends RayCast3D


var pkbl: Pickable 


func _physics_process(delta: float) -> void:
	
	if is_colliding():
		var col = get_collider()
		
		# if col is old Pickable
		if pkbl == col: 
			pass
		
		# if col is new Pickable
		elif col is Pickable:
			#if pkbl != null:
				#pkbl.on_unhover()
			pkbl = col
			pkbl.on_hover()
		
		# if col not Pickable release old Pickable
		elif pkbl != null:
			pkbl.on_unhover()
			pkbl = null

	# if not col release old Pickable
	elif pkbl != null:
		pkbl.on_unhover()
		pkbl = null
