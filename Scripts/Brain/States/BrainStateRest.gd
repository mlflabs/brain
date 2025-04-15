extends BrainState
class_name BrainStateRest

@export var time:float = 2
@export var bb:BrainBoardNpc

var current_time:float = 0

func on_enter():
	current_time = 0
	bb.npc_anim.set_state(bb.npc_anim.State.IDLE)
	
func on_exit():
	pass


func tick(delta:float):
	current_time += delta
	
	if current_time > time:
		parent.on_result(true)
