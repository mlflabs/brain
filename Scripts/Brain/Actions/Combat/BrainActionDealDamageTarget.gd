extends BrainAction
class_name BrainActionDealDamageTarget


@export var npc:NpcSmart

enum state {Start, Finished}
var current_state:state


func on_enter():
	current_state = state.Start

func tick(_delta:float):
	match  current_state:
		state.Start:
			if npc.target == null:
				return parent.on_result(false)
			if !is_instance_valid(npc.target):
				return parent.on_result(false)
			
			npc.target.damage(npc.strength)
			current_state = state.Finished
		state.Finished:
			parent.on_result(true)
