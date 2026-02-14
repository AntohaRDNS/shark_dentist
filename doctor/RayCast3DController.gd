class_name RayCast3DController
extends RayCast3D


var interactable_cur: Interactable 


func _physics_process(delta: float) -> void:
	
	if is_colliding():
		
		var col = get_collider()
		
		# if col is Interactable
		if col is Interactable:			
			# if current interactable already exist
			if interactable_cur != null:
				# if current interactable not new
				# ... unhover prev interactable
				if interactable_cur != col:
					_release_interactable_cur()
					# ... hover new interactable
					_set_interactable_cur(col)
				# if interactable is the same
				else:
					interactable_cur.while_hover()
					pass
					
			# if current Interactable not exist
			else:
				_set_interactable_cur(col)
				pass
				
			
		# if col is NOT Interactable
		elif interactable_cur != null:
			_release_interactable_cur()

	# if not colliding unhover old Interactable
	elif interactable_cur != null:
		_release_interactable_cur()
	
	
func _release_interactable_cur() -> void:
	interactable_cur.on_unhover()
	interactable_cur = null
	pass
	
	
func _set_interactable_cur(_i: Interactable) -> void:
	interactable_cur = _i
	interactable_cur.on_hover()
