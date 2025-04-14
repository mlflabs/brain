extends BrainAction
class_name BrainActionMove


@export var bb:BrainBoardNpc


func on_enter():
	bb.npc_anim.set_state(bb.npc_anim.npc_state.RUNNING)
	
	
func on_exit():
	pass
	


func tick(delta:float):
	if not bb.nav_agent.is_navigation_finished():
		var next_nav_point = bb.nav_agent.get_next_path_position()
		var direction = (next_nav_point - bb.npc.global_position).normalized()
		bb.npc.velocity = direction * bb.nav_agent.get_max_speed() 
		
		if direction.y != 1:
			bb.npc_model_root.basis = lerp(bb.npc_model_root.basis, Basis.looking_at(direction), 10.0 * delta)
		
		bb.npc.move_and_slide()
		
		
		if bb.npc.global_position.distance_to(next_nav_point) < 0.1:
			if bb.nav_agent.is_navigation_finished():
				parent.on_result(true)
			else:
				bb.nav_agent.get_next_path_position()
	else:
		parent.on_result(true)
