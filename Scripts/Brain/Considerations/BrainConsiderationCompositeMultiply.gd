extends BrainConsideration
class_name BrainConsiderationCompositeMultiply

@export
var considerations : Array[BrainConsideration] = []

func get_score():
	
	var score  = considerations[0].get_score()
	if considerations.size() == 1:
		return score
	for i in range(1, considerations.size()):
		var s = considerations[i].get_score()
		score *= s
	
	return score
		



func _ready():
	for i in get_children():
		if i is BrainConsideration:
			considerations.append(i)
		if i is BrainState:
			if state == null:
				state = i
				state.parent = self
			else:
				printerr("Only one action allowed for each consideration")

	
