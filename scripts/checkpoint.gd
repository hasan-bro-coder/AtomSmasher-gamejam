extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "player" || body.name == "ignore":
		$Checkpoint.play()
		Glob.speed += 3
		Glob.curr_level2 += 1
		Glob.dash += 10
		if len(Glob.level) == Glob.curr_level2:
			$"../../".winner()
			print("finished")
