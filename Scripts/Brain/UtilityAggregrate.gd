extends UtilityFactor
class_name UtilityAggregrate

#region Variables
@export var calculationMethod : UtilityDecision.CalculationMethod
@export var factors : Array[UtilityFactor]
#endregion


func calculate_factor_score() -> float:
	return calculate_aggregration_score()


func calculate_aggregration_score() -> float:
	var factorScores : Array[float] = []
	
	for factor in factors:
		factorScores.append(factor.calculate_factor_score())
	
	return utilityDecision.calculate_final_score(calculationMethod, factorScores)
