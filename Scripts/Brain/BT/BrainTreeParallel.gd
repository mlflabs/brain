class_name BrainTreeParallel 
extends BrainTreeNode

# Parallel: Executes all children simultaneously.
#TODO: Not implemented yet
enum Policy {
	REQUIRE_ALL,
	REQUIRE_ONE
}
var success_policy: Policy
var failure_policy: Policy

func _init(success_policy = Policy.REQUIRE_ALL, failure_policy = Policy.REQUIRE_ONE):
	self.success_policy = success_policy
	self.failure_policy = failure_policy

func execute(actor: Node) -> Status:
	var success_count = 0
	var failure_count = 0
	var running_count = 0

	for child in children:
		var status = child.execute(actor)
		if status == Status.SUCCESS:
			success_count += 1
		elif status == Status.FAILURE:
			failure_count += 1
		elif status == Status.RUNNING:
			running_count += 1

	if success_policy == Policy.REQUIRE_ALL and success_count == children.size():
		return Status.SUCCESS
	if failure_policy == Policy.REQUIRE_ALL and failure_count == children.size():
		return Status.FAILURE
	if success_policy == Policy.REQUIRE_ONE and success_count > 0:
		return Status.SUCCESS
	if failure_policy == Policy.REQUIRE_ONE and failure_count > 0:
		return Status.FAILURE
	if running_count > 0:
		return Status.RUNNING

	if children.is_empty():
		return Status.SUCCESS

	return Status.FAILURE
