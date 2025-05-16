extends BrainConsideration
class_name BCNpcHasTarget

@export var npc:NpcSmart
@export var has_target_score : float = 1
@export var no_target_score : float = 0


func get_score():
	if npc.target == null:
		return no_target_score
	if !is_instance_valid(npc.target):
		return no_target_score
	return has_target_score
