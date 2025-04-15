extends BrainAction
class_name BrainActionChangeAnim



@export var bb:BrainBoardNpc
@export var state:NpcAnim.State

func on_enter():
	bb.npc_anim.set_state(state)
	

func tick(_delta:float):
	parent.on_result(true)
