extends BrainConsideration
class_name BrainConsiderationBBHasPlayerAction

@export var bb:BrainBoard
@export var key_action: String
@export var key_action_time:String
@export var valid_key_score:float = 1
@export var invalid_key_score:float = 0
@export var time_limit_milliseconds:int = 1000


@export var curve : Curve

func get_score():
	var a = bb.blackboard.get(key_action, null)
	var t = bb.blackboard.get(key_action_time, null)
	
	if !a or !t:
		return invalid_key_score
	
	if (Time.get_ticks_msec() - t) > time_limit_milliseconds:
		return invalid_key_score
	
	return valid_key_score
	
