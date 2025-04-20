extends BrainConsideration
class_name BrainFunctionSetTargetToPlayerTargetBB

@export var bb:BrainBoardNpc


@export var curve : Curve

func get_score():
	bb.blackboard.set(PropertyManager.KEY_TARGET, PlayerManager.player.target)
	return -1
	
