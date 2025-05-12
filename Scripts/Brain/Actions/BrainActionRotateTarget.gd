extends BrainAction
class_name BrainActionRotateToTarget



@export var bb:BrainBoard
@export var tower:TowerBase

#how close to exact dirrection should we be at
@export var buffer:float = 0.5

@export var rotate_speed_key:String
@export var rotation_speed_deg_per_sec = 90.0 # Speed in degrees per second


func on_enter():
	if(bb.target == null):
		return parent.on_result(false)
	
	if(!tower.targets.has(bb.target)):
		return parent.on_result(false)
	
	if !is_instance_valid(bb.target):
		return parent.on_result(false)
	
	#_rotation_speed = bb.blackboard.get(rotate_speed_key, 0)
	
	#if _rotation_speed == 0:
	#	return parent.on_result(false)
	
func tick_physics(delta:float):
	if !is_instance_valid(bb.target):
		return parent.on_result(false)
	
	
	#### bb.root.look_at(bb.target.global_transform.origin, Vector3.UP)
	#### return parent.on_result(true)

	###############################	
	var target_position = bb.target.global_transform.origin
	var target_direction: Vector3 = (target_position - bb.root.global_transform.origin).normalized()
	
	var target_basis = Basis.looking_at(target_direction, Vector3.UP)
	var rotation_speed_rad_per_sec = deg_to_rad(rotation_speed_deg_per_sec)

	var current_basis = bb.root.global_transform.basis
	var current_forward = current_basis.z # Use current_basis.-z if -Z is forward
	var angle_difference = current_forward.angle_to(target_direction)

	var temp_transform = Transform3D(bb.root.global_transform.basis, bb.root.global_transform.origin) # Start with current basis and origin
	temp_transform = temp_transform.looking_at(target_position, Vector3.UP) # Get the basis that looks at the target

	print("DDD:  ", angle_difference, ", ", deg_to_rad(buffer))
	if angle_difference < buffer: # Use a small tolerance (e.5 degrees)
			bb.root.global_transform.basis = target_basis # Snap to target when very close to avoid tiny jitters
			return parent.on_result(true)
			
	var angle_to_rotate_this_frame = rotation_speed_rad_per_sec * delta
	var interpolation_weight = min(1.0, angle_to_rotate_this_frame / angle_difference)
	bb.root.global_transform.basis = current_basis.slerp(target_basis, interpolation_weight)
