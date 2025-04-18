extends BrainConsideration
class_name BrainConsiderationBBKeyValueEqualsPlayerAction

@export var bb:BrainBoard
@export var key: String
@export var value: PlayerManager.PlayerActions
@export var valid_key_score:float = 1
@export var invalid_key_score:float = 0


@export var curve : Curve

func get_score():
	var s = bb.blackboard.get(key, null)
	
	if !s:
		return invalid_key_score
	
	if s != value:
		return invalid_key_score
		
	return valid_key_score
	
