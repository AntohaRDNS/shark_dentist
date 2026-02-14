extends Interactable


@onready var animation_player: AnimationPlayer = $Electric_Car_Jacks/AnimationPlayer

enum Electric_Car_JacksState 
{
	default,
	growing,
	grow
}

var state: Electric_Car_JacksState = Electric_Car_JacksState.default


func _input(event) -> void:
	if event.is_action("ui_activate") and interactable_state == Electric_Car_JacksState.default and state == Electric_Car_JacksState.default:
		state = Electric_Car_JacksState.growing
		on_activate()
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


func on_activate() -> void:
	super.on_activate()
	
	animation_player.play("grow_30")
	pass
