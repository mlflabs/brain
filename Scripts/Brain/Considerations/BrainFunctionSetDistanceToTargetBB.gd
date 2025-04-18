extends BrainConsideration
class_name BrainFunctionSetDistanceToTargetBB

@export var bb:BrainBoardNpc
@export var target_key: String = PropertyManager.KEY_PLAYER
@export var target_key_in_global_board:bool = false
@export var value_key: String = "distance"
@export var value_key_in_global_board:bool = false
@export var invalid_target_key_value:float = INF


@export var curve : Curve

func get_score():
	var t 
	
	if target_key_in_global_board:
		t = GlobalBoard.blackboard.get(target_key)
	else:
		t = bb.blackboard.get(target_key)
	
	if !t or !is_instance_valid(t):
		bb.blackboard.set(value_key, invalid_target_key_value)
		return -1
	
	var d = bb.npc.global_position.distance_to(t.global_position)
	
	if value_key_in_global_board:
		GlobalBoard.blackboard.set(value_key,d)
	else:
		bb.blackboard.set(value_key, d)
	
	return -1
	
