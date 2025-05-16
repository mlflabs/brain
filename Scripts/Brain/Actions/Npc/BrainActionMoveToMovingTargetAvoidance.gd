extends BrainAction
class_name BrainActionMoveToMovingTargetAvoidance


@export var npc:NpcSmart
@export var reach_distance:float = 0

enum state { Start, MoveToTarget }
var current_state:state

var target
var current_delta:float = 0

func on_enter():
	current_state = state.Start
	npc.npc_anim.set_state(npc.npc_anim.State.RUNNING)
	#bb.nav_agent.velocity_computed.connect(Callable(on_velocity_computed))
	npc.nav_agent.velocity_computed.connect(on_velocity_computed)
	target = npc.target
	
	
func on_exit():
	npc.nav_agent.velocity_computed.disconnect(on_velocity_computed)
	#bb.nav_agent.velocity_computed.disconnect(Callable(on_velocity_computed))


	
func tick_physics(delta:float):
	match  current_state:
		state.Start:
			if target == null:
				return parent.on_result(false)

			if !is_instance_valid(target):
				return parent.on_result(false)

			current_state = state.MoveToTarget

		state.MoveToTarget:
			if is_instance_valid(target):
				npc.nav_agent.set_target_position(target.global_position)
			else:
				return parent.on_result(false)
			
			if npc.nav_agent.is_navigation_finished():
				return parent.on_result(true)	
				
			if reach_distance > 0:
				if npc.global_position.distance_to(target.global_position) < reach_distance:
					return parent.on_result(true)
			
			var next_nav_point = npc.nav_agent.get_next_path_position()	
				
			if npc.global_position.distance_to(next_nav_point) < PropertyManager.distance_reach_buffer:
				if npc.nav_agent.is_navigation_finished():
					return parent.on_result(true)
				else:
					next_nav_point = npc.nav_agent.get_next_path_position()
	
			current_delta = delta
	
			var direction = npc.global_position.direction_to(next_nav_point)
			if npc.nav_agent.avoidance_enabled:
				npc.nav_agent.set_velocity(direction * npc.nav_agent.get_max_speed())
			else:
				on_velocity_computed(direction * npc.nav_agent.get_max_speed())

			


func on_velocity_computed(vel:Vector3):
	if vel == Vector3.ZERO:
		npc.nav_agent.get_next_path_position()
		return
	npc.velocity = vel
	if vel.y != 1:
		npc.npc_model_root.basis = lerp(npc.npc_model_root.basis, Basis.looking_at(vel), 10.0 * current_delta)
		
	npc.move_and_slide()
