class_name ViewportDraw
extends SubViewport


@onready var brush: Sprite2D = $Brush
var is_inited: bool = false


func init() -> void:
	render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
	render_target_update_mode = SubViewport.UPDATE_ONCE
	pass
	
	
func move_brush(position: Vector2) -> void:
	render_target_update_mode = SubViewport.UPDATE_ONCE
	brush.set_position(position)
	pass


func brush_size() -> float:
	return brush.texture.get_height()
	pass


func clear_texture() -> void:
	render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
	render_target_update_mode = SubViewport.UPDATE_ONCE
	pass
