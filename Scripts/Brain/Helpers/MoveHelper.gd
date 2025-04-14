extends Node







func tick(_delta:float):
	if not nav_agent.is_navigation_finished():
		var next_nav_point = nav_agent.get_next_path_position()
		var direction = (next_nav_point - char_body.global_position).normalized()
		char_body.velocity = direction * nav_agent.get_max_speed() # Use the agent's max speed
		char_body.look_at(next_nav_point)
		
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
 



func rotate_model(direction: Vector3, delta : float) -> void:
	#rotate the model to match the springarm
	playermodel.basis = lerp(playermodel.basis, Basis.looking_at(direction), 10.0 * delta)
