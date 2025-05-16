extends BrainConsideration
class_name BF_RunCollable


@export var function_node:Node
@export var function_name:String



@export var curve : Curve

func get_score():

	Callable(function_node, function_name).call()
	return -1
	
