extends UtilityFactor
class_name UtilityConsideration

#region Variables
@export var contextID : String
@export var curve : Curve
#endregion


func calculate_factor_score() -> float:
	return calculate_consideration_score()


func calculate_consideration_score() -> float:
	print("WARNING: Called consideration calculation from base class which is meant to be overwritten, returns 0 (UtilityConsideration -> calculate_consideration_score)")
	return 0
