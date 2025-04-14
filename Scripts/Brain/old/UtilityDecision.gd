extends Node
class_name UtilityDecision

#region Vairables
enum CalculationMethod{
	ADD,
	SUBTRACT,
	MULTIPLY,
	DIVIDE,
	AVERAGE
}

@export var actions : Array[UtilityAction]
@export var context : Dictionary = {} ## This stores the references to any needed variables, with a STRING being used as the key and the value being whatever the context is
#endregion


func _ready() -> void:
	for action in actions:
		action.utilityDecision = self
		
		for factor in action.factors:
			factor.utilityDecision = self


func get_best_action() -> UtilityAction:
	var bestAction : UtilityAction = actions[0]
	var highestScore : float = 0
	
	for action in actions:
		var actionScore : float = action.calculate_utility_score()
		context[action.actionID] = actionScore
		
		if actionScore > highestScore:
			highestScore = actionScore
			bestAction = action
	
	return bestAction


#region Formulas
func calculate_final_score(_calculationMethod : CalculationMethod, _scores : Array[float]) -> float:
	match _calculationMethod:
		CalculationMethod.ADD:
			return calculate_via_add(_scores)
		CalculationMethod.SUBTRACT:
			return calculate_via_subtraction(_scores)
		CalculationMethod.MULTIPLY:
			return calculate_via_multiply(_scores)
		CalculationMethod.DIVIDE:
			return calculate_via_division(_scores)
		CalculationMethod.AVERAGE:
			return calculate_via_average(_scores)
		_:
			print("CALCULATION METHOD INVALID OR NOT SET UP (UtilityAICalculator -> calculate_final_score)")
			return 0


func calculate_via_add(_scores : Array[float]) -> float:
	var totalScore : float = _scores[0]
	
	for i in range(1, _scores.size()):
		totalScore += _scores[i]
	
	return totalScore


func calculate_via_subtraction(_scores : Array[float]) -> float:
	var totalScore : float = _scores[0]
	
	for i in range(1, _scores.size()):
		totalScore -= _scores[i]
	
	return totalScore


func calculate_via_multiply(_scores : Array[float]) -> float:
	var totalScore : float = _scores[0]
	
	for i in range(1, _scores.size()):
		totalScore *= _scores[i]
	
	return totalScore


func calculate_via_division(_scores : Array[float]) -> float:
	var totalScore : float = _scores[0]
	
	for i in range(1, _scores.size()):
		totalScore /= _scores[i]
	
	return totalScore


func calculate_via_average(_scores : Array[float]) -> float:
	var totalScore : float = _scores[0]
	
	for i in range(1, _scores.size()):
		totalScore += _scores[i]
	
	totalScore /= (_scores.size() - 1)
	
	return totalScore
#endregion
