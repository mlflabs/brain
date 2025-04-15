extends Node
class_name WaveManager

const CREEPS_KEY = "creeps"

@export var start_waypoints: Array[WayPoint] = []
@export var waypoint: WayPoint
@export var creep: PackedScene
@export var creep_parent: Node

@export var timer_wave:float = 5
@export var timer_creep:float = 0.5



var time:float

var creeps:Array[NpcWPCreeper] = []

func _ready() -> void:
	time = 60
	
	GlobalBoard.set_value(CREEPS_KEY, creeps)


func _physics_process(delta: float) -> void:
	time += delta
	
	if time > timer_wave:
		time = 0
		start_wave()	

func start_wave():
	var c = creep.instantiate()
	creep_parent.add_child(c)
	c.waypoint = waypoint
	c.on_destroy_callback = remove_creep
	c.npc_stats.set_life(randi_range(1,100))
	add_creep(c)
	c.position = waypoint.position


func remove_creep(node):
	creeps.erase(node)
	
func add_creep(node):
	creeps.append(node)
