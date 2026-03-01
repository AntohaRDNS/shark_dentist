class_name PaintFillCalculator
extends Node


## Calculates the fill percentage of the paint texture from a ViewportDraw.
## Emits `paint_percent_changed` whenever a new value is computed.

signal paint_percent_changed(percent: float)
signal paint_percent_full_reached

@export var auto_update: bool = false
@export var update_interval: float = 1.0
@export var color_threshold: int = 10
@export var viewport_draw: ViewportDraw
@export_range(0.0, 100.0) var paint_percent_final:  float = 50.0

var _timer: float = 0.0
var _last_percent: float = 0.0


func _process(delta: float) -> void:
	if not auto_update or viewport_draw == null:
		return
	_timer += delta
	if _timer >= update_interval:
		_timer = 0.0
		recalculate()
	pass


## Recalculates the fill percentage and emits `paint_percent_changed` if the value changed.
## Returns the fill percentage (0.0 – 100.0).
func recalculate() -> float:
	var percent := calculate_fill_percent()
	print_debug("PERCENT ", percent)
	if percent >= _last_percent:
		_last_percent = percent
		paint_percent_changed.emit(percent)
	if percent >= 100.0:
		paint_percent_full_reached.emit()
		pass
	return percent


## Returns the current fill percentage (0.0 – 100.0) without emitting a signal.
func calculate_fill_percent() -> float:
	
	var texture: ViewportTexture = viewport_draw.get_texture()
	var image: Image = texture.get_image()
	var width: int = image.get_width()
	var height: int = image.get_height()
	var total_pixels: int = width * height

	var painted_pixels: int = 0
	for y in range(height):
		for x in range(width):
			var color: Color = image.get_pixel(x, y)
			if int(color.r * 255.0) > color_threshold:
				painted_pixels += 1
	return (float(painted_pixels) / float(total_pixels)) * (100.0 / paint_percent_final) * 100 


func print_(extra_arg_0: String) -> void:
	print_debug("!!!!!! ", extra_arg_0)
	pass
