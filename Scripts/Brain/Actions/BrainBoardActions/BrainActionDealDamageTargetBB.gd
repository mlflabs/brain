extends BrainAction
class_name BrainActionDealDamageTargetBB


@export var bb:BrainBoardNpc
@export var damage_value_key:String

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
			
			target.damage(bb.blackboard.get(damage_value_key))
			current_state = state.Finished
		state.Finished:
			parent.on_result(true)
