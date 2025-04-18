extends BrainAction
class_name BrainActionFocusTargetBB


@export var bb:BrainBoardNpc


enum state {Start, Finished}
var current_state:state


func on_enter():
	current_state = state.Start

func tick(_delta:float):
	match  current_state:
		state.Start:
			var target =  bb.blackboard.get(PropertyManager.KEY_TARGET, null)
			if target == null:
				return parent.on_result(false)
			if !is_instance_valid(target):
				return parent.on_result(false)
			
			target.interupt(bb.npc)
			current_state = state.Finished
		state.Finished:
			parent.on_result(true)
