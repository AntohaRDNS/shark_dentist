class_name Syringe
extends Tool

@onready var animation_player: AnimationPlayer = $syringe/AnimationPlayer

func on_use() -> void:
	super.on_use()
	animation_player.play()
	pass
