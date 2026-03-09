class_name Tool
extends Interactable


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
