class_name Syringe
extends Tool


@onready var animation_player: AnimationPlayer = $syringe/AnimationPlayer
var shark_freez_controller: SharkFreezeController


func _ready() -> void:
	(func(): shark_freez_controller = get_tree().get_first_node_in_group("SharkFreezController")).call_deferred() # wait until all tree nodes in scene is ready
	pass


func on_use() -> void:
	super.on_use()
	shark_freez_controller.freeze(RayCast3DController.collision_point)
	animation_player.play("use_20")
	pass
