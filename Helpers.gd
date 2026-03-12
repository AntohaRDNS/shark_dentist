class_name Helpers
extends Node


static func compare_floats(a: float, b: float, epsilon: float = 0.000001) -> bool:
	return abs(a - b) < epsilon


# The correct approach is scene_file_path. Only the root node of an instanced scene has this property set; child nodes within it have it empty:
# _node is any node at subscene
static func get_instanced_scene_root(_node: Node) -> Node:
	var current := _node
	while current != null:
		if current.scene_file_path != "":
			return current
		current = current.get_parent()
	return _node
	pass
