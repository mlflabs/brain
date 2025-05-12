extends Node3D


@export var speed:float = 5;
@export var damage:int = 1
@export var lifespan:float = 1
@export var distance_buffer:float = 0.2
@export var gravity:float = 9.8
@export var target_offset:Vector3
@export var particles:particles_base

@export var area3d: Area3D
@export var area3d_area_damage: Area3D

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

	if global_position.y < PropertyManager.grond_y_level:
		finished(_target)
		

	_velocity.y -= gravity * delta

	global_position += _velocity * delta
	
	#if global_position.distance_squared_to(_target_position) < distance_buffer:
	#	finished()
	# --- Move the Arrow ---
	# Use CharacterBody3D's move_and_slide for physics-aware movement and collision
	
	# --- Rotate to Face Direction of Motion ---
	# Make the arrow node rotate to align its forward axis with its current velocity vector.
	# This makes the arrow follow its curved path visually.
	if _velocity.length_squared() > 0.0001: # Avoid looking at a zero vector if arrow stops
		look_at(global_position + _velocity, Vector3.UP) # Aim at a point one velocity-unit away

func finished(node):
	if !is_instance_valid(node):
		if !area3d_area_damage:
			node.damage(damage)
	if !particles:
		queue_free()
		return
	
	particles.start()
	
	if !area3d_area_damage:
		area3d_area_damage.monitoring = true
	
	await get_tree().create_timer(1).timeout
	

func on_area_damage(node):
	if node is NpcEnemy:
		node.damage(damage)
		return
	if node is StaticInteractableItem:
		node.damage(damage)
		return

func start(target):
	if !is_instance_valid(target):
		queue_free()
		return

	_time = 0
	_target = target
	_target_position = _target.global_position + target_offset
	setup(_target.global_position, speed)
	visible = true
	get_tree().create_timer(.2).timeout
	_moving = true
	if area3d:
		area3d.body_entered.connect(on_collide)
		area3d.area_entered.connect(on_collide)
	if area3d_area_damage:
		area3d_area_damage.body_entered.connect(on_area_damage)
		area3d_area_damage.monitorable = false

func on_collide(node):
	if node is NpcEnemy:
		finished(node)
		return
	if node is StaticInteractableItem:
		finished(node)
		return
	
	print("Another node bullet collide")
	

func setup(target_pos: Vector3, initial_horizontal_speed: float):

	var displacement = target_pos - global_position
	var horizontal_displacement = Vector3(displacement.x, 0, displacement.z)
	var vertical_displacement = displacement.y

	var horizontal_distance = horizontal_displacement.length()

	# --- Calculate Initial Velocity ---
	# We calculate the time of flight based on the horizontal speed and distance.
	# Then, we find the initial vertical velocity needed to cover the vertical displacement
	# in that calculated time, considering gravity.

	# Avoid division by zero if target is directly above/below or very close horizontally
	if horizontal_distance < 0.001:
		# Handle shooting straight up/down or at a very close target horizontally.
		# For simplicity here, we'll just shoot straight at the target with the given speed.
		# A more advanced system might use a minimum flight time or different calculation.
		if displacement.length_squared() > 0.0001:
			_velocity = displacement.normalized() * initial_horizontal_speed # Use horizontal speed as total speed
		else:
			_velocity = Vector3(0, initial_horizontal_speed, 0) # Shoot straight up if at target pos
		# We skip the projectile motion calculation below and just use this initial velocity
		look_at(global_position + _velocity, Vector3.UP) # Initial rotation
		return # Exit setup as the projectile formula isn't used for this case

	# Calculate time of flight based on horizontal distance and desired horizontal speed
	var time_of_flight = horizontal_distance / initial_horizontal_speed

	# Calculate the required initial vertical velocity using projectile motion formula:
	# vertical_displacement = initial_vertical_velocity * time_of_flight - 0.5 * gravity * time_of_flight^2
	# Rearranging for initial_vertical_velocity:
	# initial_vertical_velocity = (vertical_displacement + 0.5 * gravity * time_of_flight^2) / time_of_flight
	var initial_vertical_velocity = (vertical_displacement + 0.5 * gravity * time_of_flight * time_of_flight) / time_of_flight

	# Construct the initial velocity vector
	_velocity = horizontal_displacement.normalized() * initial_horizontal_speed + Vector3(0, initial_vertical_velocity, 0)

	# --- Initial Rotation ---
	# Rotate the arrow to initially face the direction of its calculated velocity
	# We use look_at aiming at a point slightly ahead in the direction of velocity
	if _velocity.length_squared() > 0.0001:
		look_at(global_position + _velocity, Vector3.UP)
