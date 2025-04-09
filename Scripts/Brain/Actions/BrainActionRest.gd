extends BrainAction
class_name BrainActionRest

@export
var time:float = 2

var current_time:float = 0

func on_enter():
	current_time = 0
	
func on_exit():
	pass
	


func tick(delta:float):
	current_time += delta
	
	if current_time > time:
		parent.on_result(true)
