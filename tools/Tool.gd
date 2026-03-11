class_name Tool
extends StaticBody3D

enum State
{
	default,
	grabbed,
	used
}
var interactable_state: State = State.default


func on_grab(_target: Node3D) -> void:
	print("on_grab")
	interactable_state = State.grabbed
	position = _target.position
	reparent(_target, false)
	pass


#func on_release() -> void:
	#freeze = false
	#reparent(get_tree().get_root(), true)
	#pass


func on_use()-> void:
	print("on_use")
	interactable_state = State.used
	pass
	
	
func while_use() -> void:
	print("while_use")
	interactable_state = State.used
	pass


func on_unuse() -> void:
	print("on_unuse")
	interactable_state = State.grabbed
	pass
	
