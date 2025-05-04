extends BrainAction
class_name BrainActionTowerSetTarget

@export var tower:TowerBase
@export var bb:BrainBoard

func on_enter():
	if tower.targets.is_empty():
		bb.target = null
	else:
		bb.target = tower.targets[0]
	

func tick(_delta:float):
	return parent.on_result(true)
