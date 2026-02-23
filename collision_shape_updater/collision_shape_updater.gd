@tool
class_name CollisionShapeUpdater
extends Node3D


@export var mesh_instance: MeshInstance3D
@export var collision_shape: CollisionShape3D
@export var vertex_position_mapper: VertexPositionMapper
@export var update_every_frame: bool = false

#@export_range(0, 1) var bend: float = 0
#@onready var animation_tree: AnimationTree = $Collection/AnimationTree


@export var run_update: bool = false:
	set(value):
		if value:
			_update_collision_shape()
			run_update = false


func _ready() -> void:
	_update_collision_shape()
	pass


func _physics_process(_delta: float) -> void:
	#animation_tree.set("parameters/Blend2/blend_amount", bend)
	if update_every_frame:
		_update_collision_shape()


func update_collision_shape() -> void:
	_update_collision_shape()
	pass
	

func _update_collision_shape() -> void:
	if mesh_instance == null or collision_shape == null:
		return

	var baked_mesh: ArrayMesh = mesh_instance.bake_mesh_from_current_skeleton_pose()
	if baked_mesh == null:
		push_warning("CollisionShapeUpdater: bake_mesh_from_current_skeleton_pose() returned null.")
		return
	
	vertex_position_mapper.set_mesh(baked_mesh)
	
	var trimesh_shape := baked_mesh.create_trimesh_shape()
	if trimesh_shape == null:
		push_warning("CollisionShapeUpdater: Failed to create trimesh shape from baked mesh.")
		return

	collision_shape.shape = trimesh_shape
