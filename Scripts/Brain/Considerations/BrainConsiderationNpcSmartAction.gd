extends BrainConsideration
class_name BrainConsiderationNpcSmartAction

@export var action:PlayerManager.PlayerActions
@export var npc:NpcSmart

@export var equals_value: float = 1
@export var not_equals_value: float = 0

func get_score():
	if npc.action == action:
		return equals_value
	return not_equals_value
	
