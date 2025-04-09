extends BrainConsideration
class_name BrainStaticConsideration

@export_range(0,1) var value : float = 0

@export var curve : Curve

func get_score():
	return value
