extends BrainAction
class_name BrainActionMoveWithAvoidance


@export var bb:BrainBoardNpc
	
var current_delta:float = 0


func on_enter():
	bb.npc_anim.set_state(bb.npc_anim.State.RUNNING)
	bb.nav_agent.velocity_computed.connect(_on_velocity_computed)
	
	
func on_exit():
	bb.nav_agent.velocity_computed.disconnect(_on_velocity_computed)
	

func tick_physics(delta:float):
	current_delta = delta
	var next_nav_point = bb.nav_agent.get_next_path_position()
	var direction = (next_nav_point - bb.npc.global_position).normalized()
	bb.nav_agent.set_velocity(direction * bb.nav_agent.get_max_speed())
			
	if bb.npc.global_position.distance_to(next_nav_point) < 0.1:
		if bb.nav_agent.is_navigation_finished():
			parent.on_result(true)
		else:
			bb.nav_agent.get_next_path_position()
	else:
		parent.on_result(true)

func _on_velocity_computed(vel:Vector3):
	bb.npc.velocity = vel
	if vel.y != 1:
		bb.npc_model_root.basis = lerp(bb.npc_model_root.basis, Basis.looking_at(vel), 10.0 * current_delta)
		
	bb.npc.move_and_slide()
