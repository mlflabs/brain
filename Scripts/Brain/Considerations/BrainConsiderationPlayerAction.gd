extends BrainConsideration
class_name BrainConsiderationPlayerAction

@export var action:Utils.ActionStates

@export var equals_value: float = 1
@export var not_equals_value: float = 0

func get_score():
	if PlayerManager.player.action == action:
		return equals_value
	return not_equals_value
	
