extends Node3D



const ENEMY = preload("res://scene/enemy.tscn")
const COLLECTABLES = preload("res://scene/collectables.tscn")
var positions:Array[Vector3] = [Vector3(0,0,0),Vector3(2,0,0),Vector3(-2,0,0)
#,Vector3(0,2,0),Vector3(2,2,0),Vector3(-2,2,0)
]
const CHECKPOINT = preload("res://scene/checkpoint.tscn")
# Called when the node enters the scene tree for the first time.

var last = false :
	set(value):
		$last.visible = value
func spawn(checkpoint: bool) -> void:
	for i in range(3):
		if randi_range(1,4) == 4:
			continue
		if randi_range(1,7) != 7:
			var collect = COLLECTABLES.instantiate()
			add_child(collect)
			collect.position = positions.pick_random()
			collect.position.z = 24 * i
		else:
			var enemy = ENEMY.instantiate()
			add_child(enemy)
			enemy.position = positions.pick_random()
			enemy.position.z = 24 * i
	if checkpoint:
		var point = CHECKPOINT.instantiate()
		point.position.z = -36
		add_child(point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
