extends BrainAction
class_name BrainActionMoveBBTargetToNpc


@export var bb:BrainBoardNpc
@export var npc:Npc


func on_enter():
	npc.target = bb.target

func tick(_delta:float):
	parent.on_result(true)
