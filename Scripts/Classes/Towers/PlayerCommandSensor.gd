extends Area3D
class_name PlayerCommandSensor


@export var action_callback:Callable


func action():
	if action_callback:
		action_callback.call()
	else:
		printerr("Action Callback not setup")
