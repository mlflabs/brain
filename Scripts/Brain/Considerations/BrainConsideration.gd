extends BrainBase
class_name BrainConsideration


var action : BrainAction = null
enum { THINKING, RUNNING }



func get_score():
	return 0
	

func tick(delta:float):
	action.tick(delta)


func on_enter():
	action.on_enter()
	
	
func on_exit():
	action.on_exit()


func on_result(result:bool):
	parent.on_result(result)


func _ready():
	for i in get_children():
		if i is BrainAction:
			if action == null:
				action = i
				action.parent = self
			else:
				printerr("Only one action allowed for each consideration")
	#if action == null:
	#	printerr("No action added11")	
	
