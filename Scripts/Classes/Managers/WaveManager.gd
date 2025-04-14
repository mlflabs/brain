extends Node
class_name WaveManager


@export var start_waypoints: Array[WayPoint] = []
@export var waypoint: WayPoint
@export var creep: PackedScene
@export var creep_parent: Node

@export var timer_wave:float = 5
@export var timer_creep:float = 0.5


var time:float


func _ready() -> void:
	time = 0


func _physics_process(delta: float) -> void:
	time += delta
	
	if time > timer_wave:
		time = 0
		start_wave()	

func start_wave():
	var c = creep.instantiate()
	creep_parent.add_child(c)
	c.waypoint = waypoint
	c.position = waypoint.position
	
