class_name Syringe
extends Tool


@onready var animation_player: AnimationPlayer = $syringe/AnimationPlayer
@onready var shark_freez_controller: SharkFreezeController = %shark_white/%SharkFreezController


func on_use() -> void:
	super.on_use()
	shark_freez_controller.freeze(RayCast3DController.collision_point)
	animation_player.play("use_20")
	pass
