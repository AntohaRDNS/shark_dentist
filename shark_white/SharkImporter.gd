@tool # Needed so it runs in editor.
extends EditorScenePostImport

# Called right after the scene is imported and gets the root node.
func _post_import(scene):
	iterate(scene)
	# Find skeleton and add bone attachments
	# Node find_child(pattern: String, recursive: bool = true, owned: bool = true) const

	return scene # Remember to return the imported scene


# Recursive function that is called on every node
func iterate(node):
	if node != null:
		for child in node.get_children():
			iterate(child)
		
		if node is MeshInstance3D and "teeth" in node.name:
			#node.visible = fals			
		
			var mesh = node.mesh
			if mesh == null:
				return
				
			var tooth_scene: PackedScene = load("res://shark_white/Tooth/Tooth.scn")
			var tooth_: Tooth = tooth_scene.instantiate()
			
			var node_parent = node.get_parent()
			var node_owner = node.owner
			var node_name = node.name
			var node_mesh = node.mesh
			
			node.queue_free()
			
			node_parent.add_child(tooth_)
			tooth_.owner = node_owner
			tooth_.name = node_name
			tooth_.mesh_instance_3d.mesh = node_mesh
			tooth_.position = node.position
			tooth_.rotation = node.rotation
			node.owner.set_editable_instance(tooth_, true)

			# Create CollisionShape3D with simplified convex shape
			var collision_shape = tooth_.find_child("CollisionShape3D", true, true)
			collision_shape.shape = mesh.create_convex_shape()
		
			print_rich("Post-import: Added collision hierarchy to [b]%s[/b]" % node.name)
			pass
	pass
