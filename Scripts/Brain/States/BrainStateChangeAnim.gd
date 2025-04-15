extends BrainState
class_name BrainStateChangeAnim

@export var bb:BrainBoardNpc
@export var state:NpcAnim.State

func on_enter():
	bb.npc_anim.set_state(state)
	
func on_exit():
	pass


func tick(delta:float):
	parent.on_result(true)
