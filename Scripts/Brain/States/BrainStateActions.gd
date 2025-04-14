extends BrainState
class_name BrainStateActions

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
			#we are done, with this state
			parent.on_result(result)
		else:
			next_action()
			

func on_enter():
	index = 0
	next_action()

func next_action():
	currentAction = actions[index]
	currentAction.on_enter()
	index += 1
	


	
	
func on_exit():
	pass
	


func tick(delta:float):
	currentAction.tick(delta)
