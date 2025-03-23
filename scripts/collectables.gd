extends Node3D


func die():
	$CPUParticles3D.emitting = true
	$collect.hide()

func die_bruh():
	$Area3D.monitoring = false
	$collect.hide()
	$CPUParticles3D.emitting = true
	await $CPUParticles3D.finished
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != "player":
		return
	Glob.score += 1
	Glob.dash += 1
	$"../../CanvasLayer/Control/dash".value = Glob.dash
	$"../../head/camera".shake(0.5,0.3)
	$AudioStreamPlayer.pitch_scale = 0.8+(0.2*Glob.combo)
	Glob.combo+=1
	if Glob.combo == 10:
		Glob.combo = 0
	$AudioStreamPlayer.play()
	die()
	pass # Replace with function body.



func _on_audio_stream_player_finished() -> void:
	await $CPUParticles3D.finished
	queue_free()
	pass # Replace with function body.
