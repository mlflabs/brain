extends Node
class_name WaveManager

const CREEPS_KEY = "creeps"

@export var paths:Array[Path3D]


@export var creep: PackedScene


@export var timer_wave:float = 2
@export var timer_creep:float = 0.5



var time:float

var creeps:Array[NpcPathCreeper] = []

func _ready() -> void:
	time = 10
	
	GlobalBoard.set_value(CREEPS_KEY, creeps)


func _physics_process(delta: float) -> void:
	time += delta
	
	if time > timer_wave:
		time = 0
		start_wave()	

func start_wave():
	var c = creep.instantiate()
	var rnd = randi_range(0, paths.size() - 1)
	
	paths[rnd].add_child(c)
	c.on_destroy_callback = remove_creep
	add_creep(c)


func remove_creep(node):
	creeps.erase(node)
	
func add_creep(node):
	creeps.append(node)
