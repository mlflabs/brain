extends BrainConsideration
class_name BC_Nps_Selected

@export var npc:NpcSmart
@export var value_success:float = 1
@export var value_failed:float = 0

func get_score():

	if(npc.selected):
		return value_success
	return value_failed
	
