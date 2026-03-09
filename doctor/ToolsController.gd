class_name ToolsController
extends Node


var current_tool: Tool


func _process(delta: float) -> void:	
	if current_tool == null:
		return
	
	if Input.is_action_just_pressed("ui_use"):
		current_tool.on_use()
	if Input.is_action_pressed("ui_use"):
		current_tool.while_use()
	if Input.is_action_just_released("ui_use"):
		current_tool.on_unuse()
	
	pass
