extends BrainState
class_name BrainStateRest

@export var time:float = 2
@export var npc:Npc

var current_time:float = 0

func on_enter():
	current_time = 0
	npc.set_state(Npc.npc_state.IDLE)
	
func on_exit():
	pass
	


func tick(delta:float):
	current_time += delta
	
	if current_time > time:
		parent.on_result(true)
