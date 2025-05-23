extends BrainAction
class_name BrainActionSequence

@export var repeat_until_fail:bool = false

var actions : Array[BrainAction] = []
var currentAction: BrainAction
var index:int = 0

func _ready():
	for i in get_children():
		if i is BrainAction:
			actions.append(i)
			i.parent = self
	
	if actions.is_empty():
		printerr("No actions found", self.name)

func on_result(result:bool):
	currentAction.on_exit()
	if result:
		if index == actions.size():
			if repeat_until_fail:
				index = 0
			else:
				parent.on_result(result)
		else:
			next_action()
	else:
		parent.on_result(result)
			

func on_enter():
	index = 0
	next_action()

func next_action():
	currentAction = actions[index]
	index += 1
	currentAction.on_enter()
	
func on_exit():
	currentAction.on_exit()
	
func tick(delta:float):
	currentAction.tick(delta)
	
func tick_physics(delta:float):
	currentAction.tick_physics(delta)
