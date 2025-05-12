extends BrainAction
class_name BrainActionTowerClearDeadTargets

@export var tower:TowerBase
@export var bb:BrainBoard

func on_enter():
	tower.cleanup()
	bb.target = false
	

func tick(_delta:float):
	return parent.on_result(true)
