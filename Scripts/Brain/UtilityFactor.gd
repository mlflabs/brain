extends Node
class_name UtilityFactor

var utilityDecision : UtilityDecision

func calculate_factor_score() -> float:
	print("WARNING: Called factor calculation from base class which is meant to be overwritten, returns 0 (UtilityFactor -> calculate_factor_score)")
	return 0
