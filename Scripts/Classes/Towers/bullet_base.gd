extends Node3D
class_name bullet_base

@export var speed:float = 5;
@export var damage:int = 1
@export var lifespan:float = 1
@export var distance_buffer:float = 0.2
@export var target_offset:Vector3
@export var particles:particles_base




var _target:Node3D = null
var linear_velocity:Vector3
var _moving:bool = false
var _velocity = Vector3.ZERO
var _time:float = 0
var _target_position:Vector3



func _physics_process(delta):
	if !_moving:
		return

	_time += delta
	if _time > lifespan:
		finished(_target)
		return

	if !is_instance_valid(_target):
		finished(_target)
		return

	
	global_position += _velocity * delta
	
	if global_position.distance_squared_to(_target.global_position) < distance_buffer:
		finished(_target)
	
func finished(node):
	if is_instance_valid(node):
		node.damage(damage)
	if !particles:
		queue_free()
		return
	
	particles.start()
	await get_tree().create_timer(1).timeout
	



func start(target):
	if !is_instance_valid(target):
		queue_free()
		return

	_time = 0
	_target = target
	_target_position = _target.global_position + target_offset
	setup(_target.global_position, speed)
	visible = true
	_moving = true
	


func on_collide(node):
	if node is NpcEnemy:
		finished(node)
		return
	if node is StaticInteractableItem:
		finished(node)
		return
	
	print("Another node bullet collide")
	

func setup(target_pos: Vector3, initial_horizontal_speed: float):
	look_at(target_pos)
	var displacement = target_pos - global_position
	_velocity = displacement.normalized() * initial_horizontal_speed
