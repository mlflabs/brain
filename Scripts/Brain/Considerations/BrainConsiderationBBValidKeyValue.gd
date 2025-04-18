extends BrainConsideration
class_name BrainConsiderationBBValidKeyValue

@export var bb:BrainBoard
@export var key: String
@export var valid_key_score:float = 1
@export var invalid_key_score:float = 0


@export var curve : Curve

func get_score():
	var a = bb.blackboard.get(key, null)
	
	if(!a):
		return invalid_key_score
	
	return valid_key_score
	
