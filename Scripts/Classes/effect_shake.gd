extends Effect
class_name  EffectShake




@export_category("Shake Props")
@export var shake_intensity: float = 0.1
@export var shake_speed: float = 20.0
@export var shake_cool_down: float = 0.2

@export_category("Target")
@export var mesh:Node3D


var current_shake_intensity:float = 0


var original_position: Vector3

func _ready():
	original_position = mesh.position
	
func _process(delta):
	if current_shake_intensity > 0:
		var random_offset = Vector3(
			randf_range(-current_shake_intensity, current_shake_intensity),
			randf_range(-current_shake_intensity, current_shake_intensity),
			randf_range(-current_shake_intensity, current_shake_intensity)
		)
		mesh.position = original_position + random_offset
		current_shake_intensity -= shake_cool_down
		
	else:
		mesh.position = original_position


	
func start():
	start_shake(shake_intensity, shake_speed)



func start_shake(intensity: float = 0.1, speed: float = 20.0):
	current_shake_intensity = intensity
	shake_intensity = intensity
	shake_speed = speed

func stop_shake():
	current_shake_intensity = 0
	mesh.position = original_position # Reset to original position
