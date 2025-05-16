extends Node3D
class_name resource_spawner

@export var prefabs:Array[PackedScene]
@export var markers:Array[Marker3D]
@export var max_volume:int = 5
@export var max_scale:float = 1.5
@export var min_scale:float = 0.5

@export var randomize_scale_on_ready:bool = false
@export var resources:Array[Node3D]

@export var respawn_time_inteval:float = 0

var time:float = 0
var current_marker_index: int
var marker_array:Array[int]

func _ready() -> void:
	markers.shuffle()
	if randomize_scale_on_ready:
		for r in resources:
			var s = randf_range(min_scale, max_scale)
			r.scale = s


func _process(delta: float) -> void:
	if respawn_time_inteval == 0:
		return
	
	if resources.size() >= max_volume:
		return
	
	time += delta
	
	if time > respawn_time_inteval:
		time = 0
		spawn()

func spawn():
	
	current_marker_index += 1
	if current_marker_index >= markers.size():
		current_marker_index = 0
		
	var unique_index = false
	
	while !unique_index:
		if marker_array.has(current_marker_index):
			current_marker_index += 1
			if current_marker_index >= markers.size():
				current_marker_index = 0
		else:
			unique_index = true
	marker_array.append(current_marker_index)
	
	
	var r = randi_range(0, prefabs.size() - 1)
	var n = prefabs[r].instantiate()
	n.callable = on_destroy
	n.global_position = markers[current_marker_index].global_position
	add_child(n)
	resources.append(n)
	
	
func on_destroy(node):
	resources.erase(node)
	
	
	
