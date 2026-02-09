extends Interactable


@onready var animation_player: AnimationPlayer = $Electric_Car_Jacks/AnimationPlayer

enum State 
{
	default,
	growing,
	grow
}

var state: State = State.default


func _input(event) -> void:
	if event.is_action("ui_activate") and interactable_state == State.default and state == State.default:
		state = State.growing
		activate()
	pass


func pick()-> void:
	super.pick()
	mesh_instance_3d.get_surface_override_material(0).set("albedo_color", Color.RED)
	pass


func on_hover() -> void:
	super.on_hover()
	
	if tween != null:
		tween.stop()
		tween = null
	pass

	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_method(func(value): material.set("emission_energy_multiplier", value), material.get("emission_energy_multiplier"), 1.0, 0.5).set_ease(Tween.EASE_IN)
	tween.chain().tween_method(func(value): material.set("emission_energy_multiplier", value), 1.0, 0.0, 0.5).set_ease(Tween.EASE_OUT)

	audio_stream_player.play()
	pass
	

func on_unhover() -> void:
	super.on_unhover()
	if tween != null:
		tween.stop()
		tween = null
		
	tween = get_tree().create_tween()
	tween.tween_method(func(value): material.set("emission_energy_multiplier", value), material.get("emission_energy_multiplier"), 0.0, PICK_TIME).set_ease(Tween.EASE_IN) # tween from current value to 0
	pass


func activate() -> void:
	animation_player.play("grow_30")
	pass
