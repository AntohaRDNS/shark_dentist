class_name ToolsController
extends Node

@export var marker_3d: Marker3D
var tool_current: Tool


func set_tool(_tool: Tool) -> void:
	tool_current = _tool
	tool_current.on_grab(marker_3d)
	pass


func _process(delta: float) -> void:	
	if tool_current == null:
		return
	
	if Input.is_action_just_pressed("ui_use"):
		tool_current.on_use()
	if Input.is_action_pressed("ui_use"):
		tool_current.while_use()
	if Input.is_action_just_released("ui_use"):
		tool_current.on_unuse()
	
	pass
