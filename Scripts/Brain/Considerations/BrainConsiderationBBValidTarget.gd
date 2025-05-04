extends BrainConsideration
class_name BrainConsiderationBBValidTarget

@export var bb:BrainBoard
@export var valid_key_score:float = 1
@export var invalid_key_score:float = 0


@export var curve : Curve

func get_score():

	if(bb.target == null):
		return invalid_key_score
	
	if !is_instance_valid(bb.target):
		return invalid_key_score
	
	return valid_key_score
	
