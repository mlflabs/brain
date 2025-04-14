extends Node
class_name BrainTreeAgent


var root: BrainTreeNode
var current_action: BrainAction


func _ready():
	for i in get_children():
		if i is BrainTreeNode:
			if root == null:
				root = i
				i.agent = self
			else:
				printerr("Only one Node allowed for each consideration")

func  _physics_process(delta: float) -> void:
	if current_action:
		current_action.tick_physics(delta)
		
func _process(delta: float) -> void:
	if current_action:
		current_action.tick(delta)

func tick(actor: Node):
	return root.execute(actor)
