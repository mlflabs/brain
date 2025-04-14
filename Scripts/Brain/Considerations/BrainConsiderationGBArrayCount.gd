extends BrainConsideration
class_name BrainConsiderationGBArrayCount

@export var array_key: String
@export var count_multiplier:float = 0.1
@export var max_value:float = 1
@export var key_not_found_score:float = 0

@export var curve : Curve

func get_score():
	var a = GlobalBoard.blackboard.get(WaveManager.CREEPS_KEY, null)
	
	if(a == null):
		return key_not_found_score
	
	printerr(clamp(a.size() * count_multiplier, 0, max_value), "test value")
	return clamp(a.size() * count_multiplier, 0, max_value)
