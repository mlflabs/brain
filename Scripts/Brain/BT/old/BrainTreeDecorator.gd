# btree_decorator.gd
extends BrainNode

# Inverter: Inverts the result of its child.
class Inverter extends BrainNode:
	func execute(actor: Node) -> Status:
		if children.size() != 1:
			push_error("Inverter must have exactly one child.")
			return Status.FAILURE

		var status = children[0].execute(actor)
		if status == Status.SUCCESS:
			return Status.FAILURE
		elif status == Status.FAILURE:
			return Status.SUCCESS
		return Status.RUNNING

# Repeater: Repeats the execution of its child a fixed number of times or indefinitely.
class Repeater extends BrainNode:
	var repetitions: int = -1 # -1 for infinite
	var count: int = 0

	func _init(repetitions = -1):
		self.repetitions = repetitions

	func execute(actor: Node) -> Status:
		if children.size() != 1:
			push_error("Repeater must have exactly one child.")
			return Status.FAILURE

		if repetitions == 0:
			return Status.SUCCESS

		var status = children[0].execute(actor)

		if status == Status.SUCCESS or status == Status.FAILURE:
			count += 1
			if repetitions > 0 and count >= repetitions:
				count = 0
				return Status.SUCCESS
			return Status.RUNNING
		elif status == Status.RUNNING:
			return Status.RUNNING

		return Status.FAILURE

	func _exit_tree():
		count = 0

# RepeatUntilFailure: Repeats until child returns FAILURE.
class RepeatUntilFailure extends BrainNode:
	func execute(actor: Node) -> Status:
		if children.size() != 1:
			push_error("RepeatUntilFailure must have exactly one child.")
			return Status.FAILURE

		var status = children[0].execute(actor)
		if status == Status.FAILURE:
			return Status.SUCCESS
		elif status == Status.RUNNING:
			return Status.RUNNING
		else: # Status.SUCCESS
			return Status.RUNNING

# RepeatUntilSuccess: Repeats until child returns SUCCESS.
class RepeatUntilSuccess extends BrainNode:
	func execute(actor: Node) -> Status:
		if children.size() != 1:
			push_error("RepeatUntilSuccess must have exactly one child.")
			return Status.FAILURE

		var status = children[0].execute(actor)
		if status == Status.SUCCESS:
			return Status.SUCCESS
		elif status == Status.RUNNING:
			return Status.RUNNING
		else: # Status.FAILURE
			return Status.RUNNING
