extends BrainAction
class_name BrainActionChangeStateLife

@export var npc_stats:NpcStats
@export var value:int
## connect this to BB, this way different values for different npcs....

func on_enter():
	npc_stats.change_life(value)
	

func tick(_delta:float):
	parent.on_result(true)
