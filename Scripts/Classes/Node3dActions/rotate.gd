extends Effect
class_name EffectRotation

@export var node:Node3D

@export var target_rotation_degrees: float = 360.0
@export var rotation_duration: float = 5.0
@onready var tween: Tween


func start():
	
	var target_rotation_radians = deg_to_rad(target_rotation_degrees)
	var end_rotation = node.rotation
	end_rotation.y += target_rotation_radians # Rotate around Y-axis (for 3D)
	# end_rotation.z += target_rotation_radians # Rotate around Z-axis (for 2D)
	printerr("RRRRRR ", end_rotation)
	tween = create_tween()
	tween.tween_property(node, "rotation", end_rotation, rotation_duration)
	tween.set_loops()
	tween.tween_callback(sequence_finished) # Call the function again to loop

	

func sequence_finished():
	print("Tween sequence completed!")
	node.rotation.y = 0
