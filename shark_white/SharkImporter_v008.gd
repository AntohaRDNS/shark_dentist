@tool # Needed so it runs in editor.
extends EditorScenePostImport


var	bone_attachment_up: BoneAttachment3D
var bone_attachment_down: BoneAttachment3D

var offset_up: Node3D
var offset_down: Node3D


# Called right after the scene is imported and gets the root node.
func _post_import(scene):
	
	var skeleton = scene.find_child("Skeleton3D", true, false)
	if skeleton:
		_add_bone_attachments(skeleton)
	else:
		push_error("Post-import: Could not find Skeleton3D node")
	
	iterate(scene)
	# Find skeleton and add bone attachments
	# Node find_child(pattern: String, recursive: bool = true, owned: bool = true) const

	return scene # Remember to return the imported scene


func _add_bone_attachments(skeleton: Skeleton3D):
	# Create BoneAttachment3D for upper teeth
	bone_attachment_up = BoneAttachment3D.new()
	bone_attachment_up.name = "BoneAttachment3D_teeth_up"
	bone_attachment_up.bone_name = "DEF-jaw"
	skeleton.add_child(bone_attachment_up)
	bone_attachment_up.owner = skeleton.owner
	# add offset
	offset_up = Node3D.new()
	offset_up.name = "offset"
	bone_attachment_up.add_child(offset_up)
	offset_up.owner = skeleton.owner
	# create offset with world zero position
	var bone_idx_up = skeleton.find_bone("DEF-jaw")
	var bone_transform_up = skeleton.get_bone_global_pose(bone_idx_up)
	offset_up.transform = Transform3D(bone_transform_up.inverse())
	
	# Create BoneAttachment3D for lower teeth
	bone_attachment_down = BoneAttachment3D.new()
	bone_attachment_down.name = "BoneAttachment3D_teeth_down"
	bone_attachment_down.bone_name = "DEF-jaw.002"
	skeleton.add_child(bone_attachment_down)
	bone_attachment_down.owner = skeleton.owner
	# add offset
	offset_down = Node3D.new()
	offset_down.name = "offset"
	bone_attachment_down.add_child(offset_down)
	offset_down.owner = skeleton.owner
	# create offset with world zero position
	var bone_idx_down = skeleton.find_bone("DEF-jaw.002")
	var bone_transform_down = skeleton.get_bone_global_pose(bone_idx_down)
	offset_down.transform = Transform3D(bone_transform_down.inverse())
	
	print_rich("Post-import: Added BoneAttachment3D nodes for teeth")


# Recursive function that is called on every node
func iterate(node):
	if node != null:
		for child in node.get_children():
			iterate(child)
		
		# Process MeshInstance3D nodes with "teeth_up" in name
		if node is MeshInstance3D and "teeth_up" in node.name:
			_add_collision_hierarchy_up(node)
			
		if node is MeshInstance3D and "teeth_down" in node.name:
			_add_collision_hierarchy_down(node)


func _add_collision_hierarchy_up(mesh_instance: MeshInstance3D):
	var mesh = mesh_instance.mesh
	if mesh == null:
		return
	
	# Create StaticBody3D with original mesh name
	var interactable = Interactable.new()
	interactable.name = mesh_instance.name
	interactable.mesh_instance_3d = mesh_instance

	offset_up.add_child(interactable)
	interactable.owner = offset_up.owner
	
	# Create CollisionShape3D with simplified convex shape
	var collision_shape = CollisionShape3D.new()
	collision_shape.name = "CollisionShape3D"
	collision_shape.shape = mesh.create_convex_shape()
	
	# Build hierarchy: MeshInstance3D -> StaticBody3D -> CollisionShape3D
	interactable.add_child(collision_shape)
	collision_shape.owner = offset_up.owner

	print_rich("Post-import: Added collision hierarchy to [b]%s[/b]" % mesh_instance.name)
	
	
func _add_collision_hierarchy_down(mesh_instance: MeshInstance3D):
	var mesh = mesh_instance.mesh
	if mesh == null:
		return
	
	# Create StaticBody3D with original mesh name
	var interactable = Interactable.new()
	interactable.name = mesh_instance.name
	interactable.mesh_instance_3d = mesh_instance
	
	offset_down.add_child(interactable)
	interactable.owner = offset_down.owner
	
	# Create CollisionShape3D with simplified convex shape
	var collision_shape = CollisionShape3D.new()
	collision_shape.name = "CollisionShape3D"
	collision_shape.shape = mesh.create_convex_shape()
	
	# Build hierarchy: MeshInstance3D -> StaticBody3D -> CollisionShape3D
	interactable.add_child(collision_shape)
	collision_shape.owner = offset_down.owner

	print_rich("Post-import: Added collision hierarchy to [b]%s[/b]" % mesh_instance.name)
