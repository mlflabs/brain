extends UtilityConsideration
class_name UtilityConsiderationActionIsZero


func calculate_factor_score() -> float:
	return calculate_consideration_score()


func calculate_consideration_score() -> float:
	if utilityDecision.context[contextID] <= 0:
		return 1
	else:
		return 0
