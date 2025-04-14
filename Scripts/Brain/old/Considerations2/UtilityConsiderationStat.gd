extends UtilityConsideration
class_name UtilityConsiderationStat


func calculate_factor_score() -> float:
	return calculate_consideration_score()


func calculate_consideration_score() -> float:
	var normalizedStat : float = utilityDecision.context[contextID] / curve.max_value
	var utility : float = curve.sample(normalizedStat)
	return utility
