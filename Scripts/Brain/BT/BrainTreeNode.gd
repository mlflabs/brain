extends Node
class_name BrainTreeNode

enum Status {
	SUCCESS,
	FAILURE,
	RUNNING
}

var children: Array[BrainTreeNode] = []
var agent: BrainTreeAgent

func _ready():
	
	if !agent:
		printerr("Agent not defined")
	
	for i in get_children():
		if i is BrainTreeNode:
			children.append(i)
			i.agent = agent
			


func execute(actor: Node) -> Status:
	push_error("BrainTreeNode.execute() should be overridden by subclasses.")
	return Status.FAILURE
