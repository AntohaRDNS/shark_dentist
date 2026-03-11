class_name Cleaner
extends Tool


@onready var texture_painter: TexturePainter = %TexturePainter


func on_use() -> void:
	super.on_use()
	texture_painter.toogle(true)
	pass
	

func while_use() -> void:
	super.on_use()
	pass


func on_unuse() -> void:
	super.on_unuse()
	texture_painter.toogle(false)
	pass
