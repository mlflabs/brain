extends BrainAction
class_name BrainActionParallelActions


var actions:Array[BrainAction] = []


func on_result(result:bool):
	parent.on_result(result)
			
func on_enter():
	if actions.is_empty():
		for i in get_children():
			if i is BrainAction:
				actions.append(i)
				i.parent = self
	for a in actions:
		a.on_enter()

func on_exit():
	for a in actions:
		a.on_exit()

func tick(delta:float):
	for a in actions:
		a.tick(delta)

func tick_physics(delta:float):
	for a in actions:
		a.tick_physics(delta)
