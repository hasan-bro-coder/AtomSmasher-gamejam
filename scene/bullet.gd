extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var time = 6.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.z-=1
	time -= delta
	if time <= 0:
		queue_free()
	pass


func _on_area_3d_body_entered(area: Area3D) -> void:
	var body = area.get_parent()
	if body == self:
		return
	if body.is_in_group("score"):
		body.die_bruh()
		queue_free()
	if body.is_in_group("enemy"):
		Glob.dash+=5
		body.die_bruh()
		queue_free()
	elif body.name != "player":
		queue_free()
	pass # Replace with function body.
