extends BrainConsideration
class_name BrainConsiderationRandom

@export
var min_value : float = 0

@export
var max_value : float = 0




func get_score():
	return randf_range(min_value, max_value)
