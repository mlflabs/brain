extends BrainAction
class_name BrainActionGetPlayerTarget


@export var bb:BrainBoardNpc
@export var target_key:String = "target"


func tick(_delta:float):
	if !is_instance_valid(PlayerManager.player.target):
		parent.on_result(false)
	
	bb.blackboard.set(target_key, PlayerManager.player.target)
	parent.on_result(true)
