extends BrainAction
class_name BrainActionGenerateRandomReachablePos


@export var bb_npc:BrainBoardNpc

@export var max_attempts: int  = 5
@export var min_distance: float = 2.0
@export var max_distance: float = 5.0

var result:bool = true

func on_enter():
	if bb_npc.nav_agent == null:
		printerr("Navmesh agent not specified")
		return
	var pos = get_random_position()
	
	if pos == bb_npc.npc.global_position:
		result = false
		return
	
	result = true
	bb_npc.nav_agent.set_target_position(pos)
	
	
	
func on_exit():
	pass
	


func tick(_delta:float):
	parent.on_result(result)




func get_random_position() -> Vector3:
	var nav_map = bb_npc.nav_agent.get_navigation_map()
	if not nav_map:
		printerr("Navigation map not found!")
		return bb_npc.npc.global_position # Return current position if no map

	var random_point: Vector3
	var attempts = 0
	
	while attempts < max_attempts:
		var random_radius = randf_range(min_distance, max_distance)
		var random_angle = randf_range(0, TAU) # Full circle in radians
		var random_offset = Vector3(
			random_radius * cos(random_angle),
			0, # Assuming movement on the XY plane
			random_radius * sin(random_angle)
		)
		random_point = bb_npc.npc.global_position + random_offset

		# Check if the random point is on the navigation mesh
		bb_npc.nav_agent.set_target_position(random_point)
		if bb_npc.nav_agent.is_target_reachable():
			return random_point
		attempts += 1

	printerr("Could not find a valid random point after multiple attempts.")
	return bb_npc.npc.global_position # Fallback if no valid point is found
	
