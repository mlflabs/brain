extends BrainAction
class_name BrainActionFindClosestTargetBBd


@export var bb:BrainBoard
@export var targets_array_key:String
@export var save_target_key:String

enum state {Finding, Finished}
var current_state:state


func on_enter():
	current_state = state.Finding

func tick(delta:float):
	match  current_state:
		state.Finding:
			print("looking for closest target")
			var targets = GlobalBoard.blackboard.get(targets_array_key, null)
			
			if targets == null:
				return parent.on_result(false)
			
			if targets.size() == 0:
				return parent.on_result(false)
			
			var closest_obj
			var closest_d:float = INF
			for i in range(len(targets)):
				var d = bb.npc.global_position.distance_to(targets[i].global_position)
				if d < closest_d:
					closest_d = d
					closest_obj = targets[i]

			bb.blackboard.set(save_target_key, closest_obj)
			current_state = state.Finished
				
		
		state.Finished:
			print("Found target,,,,,",)
			parent.on_result(true)
