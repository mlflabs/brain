extends BrainConsideration
class_name BrainConsiderationBBKeyValueInRange

@export var bb:BrainBoard
@export var key: String
@export var value:float
@export var type:RangeType = RangeType.Smaller
@export var invalid_key_score:float = 0
@export var in_range_score: float = 1
@export var not_in_range_score: float = 0

@export var curve : Curve

enum RangeType {Smaller, Larger}


func get_score():
	var a = bb.blackboard.get(key, null)
	
	if(!a):
		return invalid_key_score
	
	if type == RangeType.Smaller:
		if a < value:
			return in_range_score
		else:
			return not_in_range_score
	else:
		if a > value:
			return in_range_score
		else:
			return not_in_range_score
	
