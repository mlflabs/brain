extends BrainAction
class_name BrainActionMoveBBValueToNpcTarget


@export var bb:BrainBoardNpc
@export var npc:Npc
@export var bb_key:String = "target"

func on_enter():
	npc.target = bb.get_value(bb_key)

func tick(_delta:float):
	parent.on_result(true)
