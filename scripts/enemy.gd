extends Node3D


func damage():
	pass



func die():
	$CPUParticles3D.emitting = true
	$enemy.hide()

func die_bruh():
	$Area3D.monitoring = false
	$enemy.hide()
	$CPUParticles3D.emitting = true
	await $CPUParticles3D.finished
	queue_free()


func _on_audio_stream_player_finished() -> void:
	await $CPUParticles3D.finished
	queue_free()
	pass # Replace with function body.


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != "player":
		return
	die()
	body.damage()
	Glob.dash += 5
	Engine.time_scale = 0.2
	$"../../head/camera".shake()
	$"../../head/camera".focus()
	$AudioStreamPlayer.play()
