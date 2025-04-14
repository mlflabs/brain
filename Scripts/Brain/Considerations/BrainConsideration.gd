extends BrainBase
class_name BrainConsideration


var state : BrainState = null
enum { THINKING, RUNNING }



func get_score():
	return 0
	

func tick(delta:float):
	state.tick(delta)


func on_enter():
	state.on_enter()
	
	
func on_exit():
	state.on_exit()


func on_result(result:bool):
	parent.on_result(result)


func _ready():
	for i in get_children():
		if i is BrainState:
			if state == null:
				state = i
				state.parent = self
			else:
				printerr("Only one action allowed for each consideration")
	#if action == null:
	#	printerr("No action added11")	
	
