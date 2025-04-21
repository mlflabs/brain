extends BrainConsideration
class_name BrainConsiderationNpcSmartAction

@export var action:Utils.ActionStates
@export var resource: Utils.ResourceTypes = Utils.ResourceTypes.None
@export var npc:NpcSmart

@export var equals_value: float = 1
@export var not_equals_value: float = 0

func get_score():
	if npc.action == action and npc.resource == resource:
		return equals_value
	return not_equals_value
	
