extends BrainAction
class_name BrainActionRotateToTarget



@export var bb:BrainBoard
@export var tower:TowerBase

#how close to exact dirrection should we be at
@export var buffer:float = 0.0001

@export var rotate_speed_key:String
var _rotation_speed:float


func on_enter():
	if(bb.target == null):
		return parent.on_result(false)
	
	if(!tower.targets.has(bb.target)):
		return parent.on_result(false)
	
	if !is_instance_valid(bb.target):
		return parent.on_result(false)
	
	_rotation_speed = bb.blackboard.get(rotate_speed_key, 0)
	
	if _rotation_speed == 0:
		return parent.on_result(false)
	
func tick_physics(delta:float):
	if !is_instance_valid(bb.target):
		return parent.on_result(false)
	
	
	
	var target_position = bb.target.global_transform.origin
	var direction_to_target = (target_position - bb.root.global_transform.origin).normalized()

	if direction_to_target.length_squared() < buffer:
		return parent.on_result(true)
	
	
	var temp_transform = Transform3D(bb.root.global_transform.basis, bb.root.global_transform.origin) # Start with current basis and origin
	temp_transform = temp_transform.looking_at(target_position, Vector3.UP) # Get the basis that looks at the target

	var target_basis = temp_transform.basis

	# Slerp the current basis towards the target basis
	bb.root.global_transform.basis = bb.root.global_transform.basis.slerp(target_basis, _rotation_speed * delta)
	
	
	#bb.root.global_transform = bb.root.global_transform.slerp(target_transform, _rotation_speed * delta)
	
