class_name Cleaner
extends Tool


@onready var texture_painter: TexturePainter = %TexturePainter
@onready var animation_player: AnimationPlayer = $cleaner/AnimationPlayer


func on_use() -> void:
	super.on_use()
	animation_player.play("wash")
	texture_painter.toogle(true)
	pass
	

func while_use() -> void:
	super.on_use()
	pass


func on_unuse() -> void:
	super.on_unuse()
	animation_player.play("default")
	texture_painter.toogle(false)
	pass
