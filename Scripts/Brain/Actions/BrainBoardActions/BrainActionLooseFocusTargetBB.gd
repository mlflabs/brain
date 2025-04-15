extends BrainAction
class_name BrainActionLooseFocusTargetBB


@export var bb:BrainBoardNpc
@export var target_key:String

enum state { Start, Finished }
var current_state:state


func on_enter():
	current_state = state.Start

func tick(_delta:float):
	match  current_state:
		state.Start:
			var target =  bb.blackboard.get(target_key, null)
			if target == null:
				return parent.on_result(false)
				bb.blackboard.set(target_key, null)
			if !is_instance_valid(target):
				return parent.on_result(false)
				bb.blackboard.set(target_key, null)
			
			target.loose_target(bb.npc)
			current_state = state.Finished
		state.Finished:
			parent.on_result(true)
