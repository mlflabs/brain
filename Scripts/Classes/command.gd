extends Node3D
class_name PlayerCommand


@export var player : Player 
@export var playerTM: PlayerTargetManager 
@export var sensor:Area3D
@export var speed:float = 5
@export var time:float = 1


enum state {None, Start, Active, Stop}

var c_state:state = state.Stop
var c_time:float = 0

func _ready() -> void:
	sensor.body_entered.connect(on_body_entered)
	


func _process(delta: float) -> void:
	match c_state:
		state.None:
			return
		state.Active:
			c_time += delta
			if c_time > time:
				c_state = state.Stop
				return
			sensor.position.z -=  delta * speed
			
		state.Start:
			sensor.position = Vector3.ZERO
			sensor.visible = true
			sensor.monitoring = true
			c_time = 0
			c_state = state.Active


			
		state.Stop:
			c_state = state.None
			sensor.visible = false
			sensor.monitoring = false

func on_body_entered(node):
	stop()
	playerTM.add_target(node)
		
	

func start():
	c_state = state.Start

	
func stop():
	c_state = state.Stop
	print("Stop Command")
