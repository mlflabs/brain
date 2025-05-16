extends BrainConsideration
class_name BrainConsiderationBBHasTarget

@export var bb:BrainBoard
@export var has_target:float = 1
@export var no_target:float = 0


@export var curve : Curve

func get_score():
	if bb.target == null:
		return no_target
	
	if !is_instance_valid(bb.target):
		return no_target
	
	return has_target
	
	
	
