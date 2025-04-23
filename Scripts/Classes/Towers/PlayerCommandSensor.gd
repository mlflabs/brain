extends Area3D
class_name PlayerCommandSensor


@export var action_callback:Callable


func action():
	action_callback.call()
