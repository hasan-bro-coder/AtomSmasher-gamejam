extends CharacterBody3D

const BULLET = preload("res://scene/bullet.tscn")
@onready var audio: AudioStreamPlayer = $shoot
var health = 5
@onready var health_label: Label = $"../CanvasLayer/Control/health"
@onready var health_bar: ProgressBar = $"../CanvasLayer/Control/healthBar"

func _ready() -> void:
	health_label.text = str(health)
	health_bar.value = health

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_action_just_pressed("shoot"):
		audio.pitch_scale = randf_range(0.9,1.3)
		audio.play()
		var bullet = BULLET.instantiate()
		add_child(bullet)
		bullet.global_position.x = global_position.x
		bullet.global_position.y = global_position.y
		#velocity.y = JUMP_VELOCITY

	if health == 0:
		$lose.play()
		%camera.focus()
		$"../CanvasLayer/gray".show()
		$"../end".show()
		await $lose.finished
		get_tree().paused = true



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_axis("left", "right")
	position.x = lerp(position.x,input_dir*2,delta*(Glob.speed/5))
	#position.y = lerp(position.y,input_dir.y*2,delta*(Glob.speed/5))
	#position.y = direction.z
	#position.y = lerp(position.y,direction.y,800*delta)

	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
func damage():
	health -= 1
	health_label.text = str(health)
	health_bar.value = health


func _on_lose_finished() -> void:
	get_tree().paused = true

	pass # Replace with function body.
