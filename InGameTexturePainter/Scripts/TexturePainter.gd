class_name TexturePainter
extends Node3D

var camera: Camera3D
@export var mesh_instance: MeshInstance3D
@onready var vertex_position_mapper = $"../VertexPositionMapper"
@onready var viewport_draw: ViewportDraw = $"../ViewportDraw"

var material: ShaderMaterial
var recheck: bool = false
var rays_amount: int = 1
var tex_size: Vector2

var texture: ViewportTexture

func _ready() -> void:
	
	(func(): camera = get_tree().get_first_node_in_group("Camera")).call_deferred() # at the end of frame, when all nodes at tree is ready
	
	await get_tree().process_frame
	
	#vertex_position_mapper.set_mesh(mesh_instance_low_poly)
	vertex_position_mapper.init(mesh_instance)
	
	material = mesh_instance.mesh.surface_get_material(0).next_pass.next_pass
	texture = viewport_draw.get_texture()
	material.set_shader_parameter("SplatMapTexture", texture)
	
	tex_size = texture.get_size()
	pass


func toogle(_is_enable: bool) -> void:
	recheck = _is_enable
	pass
	
	
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#recheck = event.is_pressed()
	#
	#if event.is_action("ui_clear_texture") && event.is_action_pressed("ui_clear_texture"):
		#viewport_draw.clear_texture()
	#pass


func _physics_process(_delta: float) -> void:
	if recheck:
		var space_state = get_world_3d().direct_space_state
		
		for ray_idx in range(rays_amount):
			var target: Vector3
			
			if ray_idx <= 2:
				target = camera.global_transform * Vector3(0, ray_idx * viewport_draw.brush_size() * 0.2, -1000)
			else:
				target = camera.global_transform * Vector3(0, (ray_idx - 2) * viewport_draw.brush_size() * 0.2 * -1, -1000)
			
			var query = PhysicsRayQueryParameters3D.create(
				camera.global_transform.origin,
				target,
				16  # collision mask
			)
			query.exclude = []
			
			var result = space_state.intersect_ray(query)
				
			if result.size() > 0:
				var uv = vertex_position_mapper.get_uv_coords(result.position, result.normal, true)
				
				if uv:
					viewport_draw.move_brush(uv * tex_size)
