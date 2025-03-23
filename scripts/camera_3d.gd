extends Camera3D

@onready var head: Node3D = $".."
var focusing = false
var sens= 0.5
func _input(event):
	if  event is InputEventMouseMotion and not focusing:
		#rotate_y(deg_to_rad(-event.relative.x * sens))
		#head.rotation.y = lerp(rotation.y,rotation.y+deg_to_rad(-event.relative.x * sens),0.6)
		#head.rotation.y = lerp(head.rotation.y,head.rotation.y+deg_to_rad(-event.relative.x * sens),0.6)
		#body.rotate_y(deg_to_rad(event.relative.x * sens))
		head.rotation.y = lerp(head.rotation.y,head.rotation.y+deg_to_rad(-event.relative.x * sens),0.6)
		head.rotation.y = clamp(head.rotation.y, deg_to_rad(-90), deg_to_rad(45))
		head.rotation.x = lerp(head.rotation.x,head.rotation.x+deg_to_rad(-event.relative.y * sens),0.6)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-90), deg_to_rad(45))


# Shake parameters
var shake_intensity: float = 0.0
var shake_duration: float = 0.0
var shake_decay: float = 0.0

# Original camera position
var original_position: Vector3

func _ready():
	# Store the original position of the camera
	original_position = transform.origin

func _process(delta):
	if shake_duration > 0:
		# Apply random offset to the camera's position
		transform.origin = original_position + Vector3(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)

		# Reduce shake intensity over time
		shake_intensity = max(shake_intensity - shake_decay * delta, 0.0)
		shake_duration -= delta
	else:
		# Reset to the original position when shaking is done
		transform.origin = original_position


func focus():
	focusing = true
	var tween = create_tween()
	tween.tween_property(head,"rotation",Vector3(deg_to_rad(-16.5),deg_to_rad(18.5),0),0.3)
	#position = Vector3(1.357,1.28,4.01)
	#rotation = Vector3(0,3.5,0)
	tween.play()
	tween.finished.connect(func():
		focusing = false
		Engine.time_scale = 1
		)
func shake(duration=0.5, intensity=0.5, decay=2.0):
	shake_duration = duration
	shake_intensity = intensity
	shake_decay = decay
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
