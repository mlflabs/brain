extends BrainAction
class_name BrainActionTowerClearDeadTargets

@export var tower:TowerBase

func on_enter():
	tower.cleanup()

func tick(_delta:float):
	return parent.on_result(true)
