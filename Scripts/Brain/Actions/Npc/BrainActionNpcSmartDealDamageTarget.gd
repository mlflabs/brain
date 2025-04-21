extends BrainAction
class_name BrainActionNpcSmartDealDamageTarget


@export var npc:NpcSmart

enum States {Start, Finished}
var state:States


func on_enter():
	state = States.Start

func tick(_delta:float):
	match  state:
		States.Start:
			if npc.target == null:
				return parent.on_result(false)
			if !is_instance_valid(npc.target):
				return parent.on_result(false)
			
			npc.target.damage(npc.stats.strength)
			state = States.Finished
		States.Finished:
			parent.on_result(true)
