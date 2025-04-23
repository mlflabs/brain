extends Node3D
class_name  BuildTowerSelections



@export var selections:Array[BuildTowerSelection] = []
@export var pcs:PlayerCommandSensor
@export var manager:TowerNoTower

var selected:BuildTowerSelection

var index:int = -1

func _ready():
	pcs.action_callback = Callable(self, "select_next")
	for s in selections:
		s.set_selected(false)

func select_next():
	index += 1
	
	if index == selections.size():
		index = 0
	
	for s in selections:
		s.set_selected(false)
	
	selected = selections[index]
	manager.set_selection(selected)
	selected.set_selected(true)
			
	
	
