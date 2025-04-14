# btree_leaf.gd
extends BrainTreeNode

# Action: Represents an action to be performed by the actor.
class Action extends BrainTreeNode:
	var action_func: Callable

	func _init(action_func: Callable):
		self.action_func = action_func

	func execute(actor: Node) -> Status:
		if action_func.is_valid():
			return action_func.call(actor) as Status
		else:
			push_error("Invalid action function.")
			return Status.FAILURE

# Condition: Represents a check that returns SUCCESS or FAILURE.
class Condition extends BrainTreeNode:
	var condition_func: Callable

	func _init(condition_func: Callable):
		self.condition_func = condition_func

	func execute(actor: Node) -> Status:
		if condition_func.is_valid():
			if condition_func.call(actor) as bool:
				return Status.SUCCESS
			else:
				return Status.FAILURE
		else:
			push_error("Invalid condition function.")
			return Status.FAILURE
