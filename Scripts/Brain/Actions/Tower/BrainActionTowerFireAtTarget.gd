extends BrainAction
class_name BrainActionTowerSetTarget

@export var tower:TowerBase
@export var bb:BrainBoard

		

func tick(_delta:float):
	if tower.targets.is_empty():
		bb.target = null
	else:
		for t in tower.targets:
			if is_instance_valid(t):
				bb.target = t
				print("Found Target")
				return parent.on_result(true)
			else:
				tower.targets.erase(t)
	bb.target = null
	printerr("Targetrs::: ", tower.targets.size())
	return parent.on_result(false)
