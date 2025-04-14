extends BrainTreeNode
class_name BrainTreeSequence 
#TODO: Not implemented yet


# Sequence: Executes children in order until one fails.
func execute(actor: Node) -> Status:
	for child in children:
		var status = child.execute(actor)
		if status == Status.FAILURE:
			return Status.FAILURE
		elif status == Status.RUNNING:
			return Status.RUNNING
	return Status.SUCCESS
