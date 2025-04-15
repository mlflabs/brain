extends BrainState
class_name BrainStateWander


@export var nav_agent:NavigationAgent3D
@export var char_body: CharacterBody3D
@export var npc:Npc

@export var min_distance: float = 2.0
@export var max_distance: float = 5.0


func on_enter():
	# get random position
	if nav_agent == null:
		printerr("Navmesh agent not specified")
		return
	var pos = get_random_position()
	
	nav_agent.set_target_position(pos)
	npc.set_state(Npc.State.RUNNING)
	
func on_exit():
	pass
	


func tick(delta:float):
	if not nav_agent.is_navigation_finished():
		var next_nav_point = nav_agent.get_next_path_position()
		var direction = (next_nav_point - char_body.global_position).normalized()
		char_body.velocity = direction * nav_agent.get_max_speed() # Use the agent's max speed
		#char_body.look_at(next_nav_point)
		rotate_model(direction, delta)
		# Move the agent (you'll likely need to integrate this with your character controller)
		# For a simple example, you can directly set the global_position,
		# but for more complex movement, use move_and_slide or similar methods.
		#####global_position += velocity * delta
		char_body.move_and_slide()
		
		
		if char_body.global_position.distance_to(next_nav_point) < 0.1:
			if nav_agent.is_navigation_finished():
				parent.on_result(true)
			else:
				nav_agent.get_next_path_position() # Advance to the next point in the path
	else:
		# Reached the target, get a new one
		parent.on_result(true)



func get_random_position() -> Vector3:
	var nav_map = nav_agent.get_navigation_map()
	if not nav_map:
		printerr("Navigation map not found!")
		return char_body.global_position # Return current position if no map

	var random_point: Vector3
	var attempts = 0
	var max_attempts = 10 # Avoid infinite loops

	while attempts < max_attempts:
		var random_radius = randf_range(min_distance, max_distance)
		var random_angle = randf_range(0, TAU) # Full circle in radians
		var random_offset = Vector3(
			random_radius * cos(random_angle),
			0, # Assuming movement on the XY plane
			random_radius * sin(random_angle)
		)
		random_point = char_body.global_position + random_offset

		# Check if the random point is on the navigation mesh
		nav_agent.set_target_position(random_point)
		if nav_agent.is_target_reachable():
			return random_point
		attempts += 1

	printerr("Could not find a valid random point after multiple attempts.")
	return char_body.global_position # Fallback if no valid point is found
	

	
func _on_navigation_finished():
	# Called when the agent reaches its target.
	# We are already setting a new target in _physics_process,
	# but you could add additional logic here if needed.
	pass

func rotate_model(direction: Vector3, delta : float) -> void:
	npc.playermodel.basis = lerp(npc.playermodel.basis, Basis.looking_at(direction), 10.0 * delta)
	
	
func _on_navigation_path_changed():
	# Called when the navigation path is recalculated.
	# You might want to do something here if the path changes unexpectedly.
	pass
