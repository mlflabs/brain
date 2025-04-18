extends BrainAction
class_name BrainActionFollowTargetBB


@export var bb:BrainBoardNpc
@export var use_global_board:bool = false
@export var reach_distance:float = 0
@export var target_key:String = PropertyManager.KEY_PLAYER

enum state { Start, MoveToTarget }
var current_state:state

var target

func on_enter():
	current_state = state.Start
	
func tick(delta:float):
	match  current_state:
		state.Start:
			var t
			
			if use_global_board:
				t = GlobalBoard.blackboard.get(target_key)
			else:
				t = bb.blackboard.get(target_key)
			
			if t == null:
				return parent.on_result(false)

			if !is_instance_valid(t):
				return parent.on_result(false)

			target = t
			current_state = state.MoveToTarget

		state.MoveToTarget:
			if is_instance_valid(target):
				bb.nav_agent.set_target_position(target.global_position)
			else:
				return parent.on_result(false)
			
			if bb.nav_agent.is_navigation_finished():
				return parent.on_result(true)			
			
			if reach_distance > 0:
				if bb.npc.global_position.distance_to(target.global_position) < reach_distance:
					return parent.on_result(true)
			
			var pos = bb.nav_agent.get_next_path_position()
			var d = bb.npc.global_position.distance_to(pos)
			
			var dir = (pos - bb.npc.global_position).normalized()
			bb.npc.velocity = dir * bb.nav_agent.get_max_speed() 
			if dir.y != 1:
				bb.npc_model_root.basis = lerp(bb.npc_model_root.basis, Basis.looking_at(dir), 10.0 * delta)
			bb.npc.move_and_slide()
			

	
