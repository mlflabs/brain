extends BrainAction
class_name BrainActionMoveToMovingTargetAvoidanceBB


@export var bb:BrainBoardNpc
@export var reach_distance:float = 0
@export var target_key:String = PropertyManager.KEY_TARGET

enum state { Start, MoveToTarget }
var current_state:state

var target
var current_delta:float = 0

func on_enter():
	current_state = state.Start
	bb.npc_anim.set_state(bb.npc_anim.State.RUNNING)
	#bb.nav_agent.velocity_computed.connect(Callable(on_velocity_computed))
	bb.nav_agent.velocity_computed.connect(on_velocity_computed)
	
	
func on_exit():
	bb.nav_agent.velocity_computed.disconnect(on_velocity_computed)
	#bb.nav_agent.velocity_computed.disconnect(Callable(on_velocity_computed))


	
func tick_physics(delta:float):
	match  current_state:
		state.Start:
			var t = bb.blackboard.get(PropertyManager.KEY_TARGET)
			
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
			
			var next_nav_point = bb.nav_agent.get_next_path_position()	
				
			if bb.npc.global_position.distance_to(next_nav_point) < PropertyManager.distance_reach_buffer:
				if bb.nav_agent.is_navigation_finished():
					return parent.on_result(true)
				else:
					next_nav_point = bb.nav_agent.get_next_path_position()
	
			current_delta = delta
	
			var direction = bb.npc.global_position.direction_to(next_nav_point)
			if bb.nav_agent.avoidance_enabled:
				bb.nav_agent.set_velocity(direction * bb.nav_agent.get_max_speed())
			else:
				on_velocity_computed(direction * bb.nav_agent.get_max_speed())

			


func on_velocity_computed(vel:Vector3):
	if vel == Vector3.ZERO:
		bb.nav_agent.get_next_path_position()
		return
	bb.npc.velocity = vel
	if vel.y != 1:
		bb.npc_model_root.basis = lerp(bb.npc_model_root.basis, Basis.looking_at(vel), 10.0 * current_delta)
		
	bb.npc.move_and_slide()
