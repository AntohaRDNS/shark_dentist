extends LookAtModifier3D


@onready var target: Node3D = get_tree().get_nodes_in_group("doctor")[0]


func _ready() -> void:
	target_node = target.get_path()
	pass
