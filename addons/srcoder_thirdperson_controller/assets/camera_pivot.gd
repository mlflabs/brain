extends Node3D

const MOUSE_SENSITIVITY = 0.002
#rotate the springarm for pitch
@onready var springarm : Node3D = $SpringArm3D

	
func _input(event: InputEvent) -> void:
	return
	if event is InputEventMouseMotion:
		rotate_y(event.relative.x * -MOUSE_SENSITIVITY)
		springarm.rotation.x = clamp(springarm.rotation.x - event.relative.y * MOUSE_SENSITIVITY,-0.6,0.6)
