extends BrainTreeNode
class_name BrainTreeAction

#Wrapper for BrainAction

#### stopped here, trying to connect brain action to the tree leafs.....
var action_status:Status 

	
func on_enter():
	action_status = Status.RUNNING 
	
	
func on_exit():
	pass
	

func _tick(delta:float):
	pass

func _tick_physics(delta:float):
	pass


func execute(actor: Node) -> Status:
	
	return Status.FAILURE
