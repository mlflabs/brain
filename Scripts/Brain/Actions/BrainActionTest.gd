extends BrainAction
class_name BrainActionTest

var count:int = 0

func on_enter():
	count = 2
	
func on_exit():
	pass
	


func tick(_delta:float):
	print("TestAction: {}", count)
	count -= 1
	if count == 0:
		parent.on_result(true)
