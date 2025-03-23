extends Node3D


@onready var player: CharacterBody3D = $player
@onready var main: Node3D = $main
@onready var blockes: Array[Node3D] = []
var blockcount = 6
#@onready var back: Node3D = $back
#@onready var front: Node3D = $front
const BLOCK = preload("res://scene/block.tscn")
# Called when the node enters the scene tree for the first time.

var dashing = false
@onready var camera: Camera3D = %camera

func _ready() -> void:
	#camera.rotation = Vector3(90,0,0)
	Glob.curr_level2 = 0
	Glob.curr_level = 1
	Glob.combo = 0
	Glob.score = 0
	Glob.dash = 0
	Glob.speed = 40
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	for i in range(blockcount):
		var tmp = BLOCK.instantiate()
		##front = tmp
		tmp.position.z = -72*(len(blockes)+1)
		add_child(tmp)
		Glob.curr_level += 1
		if Glob.curr_level == Glob.level[Glob.curr_level2]:
			Glob.curr_level = 0
			tmp.spawn(true)
		else:
			tmp.spawn(false)
		blockes.append(tmp)
	blockes[-1].last = true
	get_tree().paused = true
	pass # Replace with function body.1.357,1.28,4.01


#var speed = 60
var won = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dashing:
		$CanvasLayer/Control/dash.value -= 0.2

		Engine.time_scale = 5
	if won:
		return
	if Input.is_action_just_pressed("dash") and Glob.dash >= 60:
		$dash2.play()
		$CanvasLayer/high.show()
		camera.focus()
		Engine.time_scale = 5
		player.name = "ignore"
		dashing = true
		$dash.start()

		#Engine.time_scale = 5


	main.position.z += Glob.speed * delta
	for i in blockes:
		#var el: Node3D = blockesi]
		i.position.z += Glob.speed * delta

	#front.position.z += 10 * delta

	if main.position.z >= 71:
		##var tmp = main
		main.queue_free()
		main = blockes[0]
		blockes.pop_front()
		var tmp = BLOCK.instantiate()
		##front = tmp
		tmp.position.z = -71*(len(blockes)+1)
		add_child(tmp)
		blockes[-1].last = false
		blockes.append(tmp)
		blockes[-1].last = true
		Glob.curr_level += 1
		if len(Glob.level) != 0 and Glob.curr_level == Glob.level[0]:
				Glob.level.pop_front()
				Glob.curr_level = 0
				tmp.spawn(true)
		else:
			tmp.spawn(false)
	pass


func _on_play_pressed() -> void:
	$menu/AudioStreamPlayer.stop()
	$AudioStreamPlayer.play()
	$menu.hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var tween = create_tween()
	tween.tween_property(camera,"rotation",Vector3(0,0,0),0.3)
	tween.play()
	$CanvasLayer.show()
	pass


func _on_exit_pressed() -> void:
	get_tree().quit()
	pass

func _on_dash_timeout() -> void:
	$CanvasLayer/high.hide()
	Engine.time_scale = 1
	player.name = "player"
	$dash.stop()
	$CanvasLayer/Control/dash.value = 0
	Glob.dash = 0
	dashing = false
	pass # Replace with function body.

func winner():
	if dashing:
		await $dash.timeout

	won = true
	camera.focus()
	$outro.play()
	#camera.shake(20,1,1)
	await get_tree().create_timer(10).timeout
	player.name = "ignoreh"
	var tween = create_tween()
	tween.tween_property(player,"position:z",-900,3)
	#position = Vector3(1.357,1.28,4.01)
	#rotation = Vector3(0,3.5,0)
	tween.play()
	#$end/Control/Label.text = "You Won"
	tween.finished.connect(func():
		$head.rotation = Vector3.ZERO
		$loop.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		camera.focusing = true
		camera.top_level = true
		var ctween = create_tween()
		ctween.tween_property(camera,"rotation:x",deg_to_rad(-90),2.5)
		ctween.finished.connect(func():
			for i in blockes:
				i.queue_free()
			main.queue_free()
			var ttween = create_tween()
			ttween.tween_property(camera,"position:y",300,2.5)
			ttween.finished.connect(func():
				$win.play()
				$end.show()
				camera.position = Vector3(0,300,0)
				camera.rotation = Vector3(-90,0,0)
				get_tree().paused = true

				#await $win.finished
			)
		)
	)

func _on_playagain_pressed() -> void:
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_tutorial_pressed() -> void:
	$menu/Control2.show()

	pass # Replace with function body.


func _on_close_pressed() -> void:
	$menu/Control2.hide()
	pass # Replace with function body.
