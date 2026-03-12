class_name Cleaner
extends Tool


@onready var animation_player: AnimationPlayer = $cleaner/AnimationPlayer
var texture_painter: TexturePainter


func _ready() -> void:
	(func(): texture_painter = get_tree().get_first_node_in_group("TexturePainter")).call_deferred()
	pass
	

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
