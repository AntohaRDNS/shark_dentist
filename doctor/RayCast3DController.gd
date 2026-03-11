class_name RayCast3DController
extends RayCast3D

@export var tools_controller: ToolsController
@export var marker_3d: Marker3D

static var interactable_selected: Interactable
static var collision_point: Vector3


func _physics_process(delta: float) -> void:

	#if Input.is_action_just_pressed("ui_action"):
		#if marker_3d.get_child_count() > 0:
			#var i = marker_3d.get_child(0)
			#i.on_release()
			#pass
		#pass
	
	if is_colliding():
		
		var col = get_collider()
		collision_point = get_collision_point()
		print(col.name)
		print_debug(col.is_in_group("Interactable"))
		
		# if placeholder try to release Interactable
		if col.is_in_group("placeholder"):
			if Input.is_action_just_pressed("ui_grab"):
				if marker_3d.get_child_count() > 0:
					var i = marker_3d.get_child(0)
					i.on_grab(col)
					pass
			print(col.name)
			pass
		
		# if col has Interactable capabilities
		if col.is_in_group("Interactable"):
			var i: Interactable = (col.get_node("%Interactable") as Interactable)
			# get collision point
			# if current interactable already exist
			if interactable_selected != null:
				# if current interactable not new
				# ... unhover prev interactable
				if interactable_selected != i:
					_unselect_interactable_cur()
					# ... hover new interactable
					_select_interactable_cur(i)
				# if interactable is the sameww
				else:
					if Input.is_action_just_pressed("ui_grab"):
						if marker_3d.get_child_count() == 0: 
							interactable_selected.on_grab(marker_3d) # grab only if not grabb
							if col is Tool:
								tools_controller.current_tool = col
					interactable_selected.while_hover()
					pass
					
			# if current Interactable not exist
			else:
				_select_interactable_cur(i)
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
