extends BrainTreeNode
class_name  BrainTreeSelector
#TODO: Not implemented yet


# Selector (Fallback): Executes children in order until one succeeds.
func execute(actor: Node) -> Status:
	for child in children:
		var status = child.execute(actor)
		if status == Status.SUCCESS:
			return Status.SUCCESS
		elif status == Status.RUNNING:
			return Status.RUNNING
	return Status.FAILURE
