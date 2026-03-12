class_name Gloves
extends Tool


var grab_joint: ConeTwistJoint3D
var grab_anchor: StaticBody3D
var grabbed_bone: PhysicalBone3D


func on_use():
	grabbed_bone = $Skeleton3D/bone_3  # adjust path as needed

	grab_anchor = StaticBody3D.new()
	grab_anchor.global_transform = grabbed_bone.global_transform
	get_tree().root.add_child(grab_anchor)

	grab_joint = ConeTwistJoint3D.new()
	get_tree().root.add_child(grab_joint)
	grab_joint.global_position = grabbed_bone.global_position
	grab_joint.node_a = grab_anchor.get_path()
	grab_joint.node_b = grabbed_bone.get_path()


func while_use():
	if grab_anchor:
		grab_anchor.global_position = RayCast3DController.collision_point


func release():
	if grab_joint:
		grab_joint.queue_free()
		grab_joint = null
	if grab_anchor:
		grab_anchor.queue_free()
		grab_anchor = null
	grabbed_bone = null
