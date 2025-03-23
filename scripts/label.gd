extends Label

func _ready() -> void:
	if !OS.has_feature("debug"):
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	text = str(Glob.score) 	if name == "score" else str(Engine.get_frames_per_second())

	pass
