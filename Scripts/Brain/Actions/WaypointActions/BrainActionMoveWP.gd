extends BrainAction
class_name BrainActionMove


@export var bb:BrainBoardNpc


func on_enter():
	bb.npc.set_state(Npc.npc_state.RUNNING)
	
	
func on_exit():
	pass
	


func tick(delta:float):
	if not bb.nav_agent.is_navigation_finished():
		var next_nav_point = bb.nav_agent.get_next_path_position()
		var direction = (next_nav_point - bb.npc.global_position).normalized()
		bb.npc.velocity = direction * bb.nav_agent.get_max_speed() 
		rotate_model(direction, delta)
		bb.npc.move_and_slide()
		
		
		if bb.npc.global_position.distance_to(next_nav_point) < 0.1:
			if bb.nav_agent.is_navigation_finished():
				parent.on_result(true)
			else:
				bb.nav_agent.get_next_path_position()
	else:
		parent.on_result(true)


func rotate_model(direction: Vector3, delta : float) -> void:
	bb.npc.playermodel.basis = lerp(bb.npc.playermodel.basis, Basis.looking_at(direction), 10.0 * delta)
	
