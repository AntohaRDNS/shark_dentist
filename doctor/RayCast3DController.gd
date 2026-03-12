class_name RayCast3DController
extends RayCast3D

@export var tools_controller: ToolsController

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
		var subscene_root = Helpers.get_instanced_scene_root(col)
			
		collision_point = get_collision_point()
		
		# if placeholder try to release Interactable
		if subscene_root.is_in_group("placeholder"):
			if Input.is_action_just_pressed("ui_grab"):
				#if marker_3d.get_child_count() > 0:
					#var i = marker_3d.get_child(0)
					#i.on_grab(col)
					pass
			pass
			
		if subscene_root is Tool:
			if Input.is_action_just_pressed("ui_grab"):
				
				if tools_controller.tool_current != null:
					tools_controller.tool_current.on_release()
				
				tools_controller.set_tool(subscene_root)
		
		# if col has Interactable capabilities
		if subscene_root.is_in_group("Interactable"):
			var i: Interactable = (subscene_root.get_node("%Interactable") as Interactable)
			# get collision point
			# if current interactable already exist
			if interactable_selected != null:
				# if current interactable not new
				# ... unhover prev interactable
				if interactable_selected != i:
					_unselect_interactable_cur()
					# ... hover new interactable
					_select_interactable_cur(i)
				# if interactable is the same
				else:
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
