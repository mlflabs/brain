extends BrainConsideration
class_name BCTowerHasTargets

@export var tower:TowerBase
@export var has_targets_score : float = 1
@export var no_targets_score : float = 0




func get_score():
	if tower.targets.is_empty():
		return no_targets_score
	return has_targets_score
