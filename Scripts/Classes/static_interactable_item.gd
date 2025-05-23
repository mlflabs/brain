extends StaticBody3D
class_name  StaticInteractableItem



@export_category("Props")
@export var type:Utils.ResourceTypes = Utils.ResourceTypes.None
@export var effect:Utils.EffectTypes = Utils.EffectTypes.None


@export_category("Shake Props")
@export var shake_intensity: float = 0.1
@export var shake_speed: float = 20.0
@export var shake_cool_down: float = 0.2

var callable:Callable

var current_shake_intensity:float = 0


var original_position: Vector3

func _ready():
	await get_tree().process_frame
	original_position = position
	MapManager.level.register_item(self)
	
func _process(delta):
	if current_shake_intensity > 0:
		var random_offset = Vector3(
			randf_range(-current_shake_intensity, current_shake_intensity),
			randf_range(-current_shake_intensity, current_shake_intensity),
			randf_range(-current_shake_intensity, current_shake_intensity)
		)
		position = original_position + random_offset
		current_shake_intensity -= shake_cool_down
		
	else:
		position = original_position



func interact():
	if effect == Utils.EffectTypes.Shake:
		start_shake(shake_intensity, shake_speed)

func damage(value:int):
	interact()

func start_shake(intensity: float = 0.1, speed: float = 20.0):
	current_shake_intensity = intensity
	shake_intensity = intensity
	shake_speed = speed

func stop_shake():
	current_shake_intensity = 0
	position = original_position # Reset to original position


func remove():
	MapManager.level.remove_item(self)
	if callable:
		callable.call(self)
	queue_free()
