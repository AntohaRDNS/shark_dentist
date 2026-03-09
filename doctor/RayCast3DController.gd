class_name RayCast3DController
extends RayCast3D


@onready var marker_3d: Marker3D = $"../Marker3D"
var interactable_selected: Interactable


func _physics_process(delta: float) -> void:

	#if Input.is_action_just_pressed("ui_action"):
		#if marker_3d.get_child_count() > 0:
			#var i = marker_3d.get_child(0)
			#i.on_release()
			#pass
		#pass
	
	if is_colliding():
		
		var col = get_collider()
		
		# if placeholder try to release Interactable
		if col.is_in_group("Placeholder"):
			if Input.is_action_just_pressed("ui_grab"):
				if marker_3d.get_child_count() > 0:
					var i = marker_3d.get_child(0)
					i.on_grab(col)
					pass
			print(col.name)
			pass
		
		# if col is Interactable
		if col is Interactable:
			# if current interactable already exist
			if interactable_selected != null:
				# if current interactable not new
				# ... unhover prev interactable
				if interactable_selected != col:
					_unselect_interactable_cur()
					# ... hover new interactable
					_select_interactable_cur(col)
				# if interactable is the same
				else:
					if Input.is_action_just_pressed("ui_grab"):
						if marker_3d.get_child_count() == 0: interactable_selected.on_grab(marker_3d) # grab only if not grabb
					if Input.is_action_just_pressed("ui_use"):
						col.on_use()
					interactable_selected.while_hover()
					pass
					
			# if current Interactable not exist
			else:
				_select_interactable_cur(col)
				pass
				
		# if col is NOT Interactable
		elif interactable_selected != null:
			_unselect_interactable_cur()

	# if not colliding unhover old Interactable
	elif interactable_selected != null:
		_unselect_interactable_cur()
	
	
func _unselect_interactable_cur() -> void:
	interactable_selected.on_unhover()
	interactable_selected = null
	pass
	
	
func _select_interactable_cur(_i: Interactable) -> void:
	interactable_selected = _i
	interactable_selected.on_hover()
