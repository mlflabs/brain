extends BrainAction
class_name BrainActionTowerSetTargetForNpc

@export var tower:TowerBase
@export var npcs: Array[NpcSmart]

func on_enter():
	if tower.targets.is_empty():
		return
	for n in npcs:
		n.target = tower.targets[0]

func tick(_delta:float):
	return parent.on_result(true)
	
