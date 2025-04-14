extends CharacterBody3D


enum State {
	WALK,
	WALKING,
	JUMPING,
	ATTACKING
}

var current_state: State = State.IDLE
var owner: Node # The node this state machine controls

# Optional: Store state-specific data
var walk_direction: Vector2 = Vector2.ZERO
var jump_velocity: float = 0.0

func _ready():
	# Find the owner node (the node this script is attached to)
	owner = get_parent()
	if not is_instance_valid(owner):
		printerr("Error: State machine owner not found!")
		queue_free() # Or handle the error appropriately

func _physics_process(delta):
	match current_state:
		State.IDLE:
			_state_idle(delta)
		State.WALKING:
			_state_walking(delta)
		State.JUMPING:
			_state_jumping(delta)
		State.ATTACKING:
			_state_attacking(delta)
		_:
			printerr("Error: Unknown state!")

# --- State Functions ---

func _state_idle(delta):
	# Behavior specific to the IDLE state
	owner.velocity.x = lerp(owner.velocity.x, 0.0, 0.2) # Example: Gradually stop horizontal movement

	# Transition conditions
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		_change_state(State.WALKING)
	if Input.is_action_just_pressed("jump"):
		_change_state(State.JUMPING)
	if Input.is_action_just_pressed("attack"):
		_change_state(State.ATTACKING)

func _state_walking(delta):
	# Behavior specific to the WALKING state
	walk_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0.0
	).normalized()
	owner.velocity.x = walk_direction.x * owner.walk_speed # Assuming 'owner' has a 'walk_speed' property

	# Transition conditions
	if walk_direction == Vector2.ZERO:
		_change_state(State.IDLE)
	if Input.is_action_just_pressed("jump"):
		_change_state(State.JUMPING)
	if Input.is_action_just_pressed("attack"):
		_change_state(State.ATTACKING)

func _state_jumping(delta):
	# Behavior specific to the JUMPING state
	owner.velocity.y += owner.gravity * delta # Assuming 'owner' has a 'gravity' property
	owner.velocity.x = lerp(owner.velocity.x, 0.0, 0.1) # Some air control

	# Apply initial jump impulse (only once when entering the state)
	if jump_velocity > 0:
		owner.velocity.y = -jump_velocity
		jump_velocity = 0 # Reset the impulse

	# Transition conditions
	if owner.is_on_floor(): # Assuming 'owner' is a CharacterBody2D or similar
		_change_state(State.IDLE) # Or State.WALKING if a movement key is pressed

func _state_attacking(delta):
	# Behavior specific to the ATTACKING state
	# Play attack animation, deal damage, etc.
	print("Attacking!")
	# You might want to use a timer or animation signals to control the attack duration

	# Transition conditions
	# Example: After a short delay, return to IDLE
	await get_tree().create_timer(0.5).timeout
	_change_state(State.IDLE)

# --- Helper Functions ---

func _change_state(new_state: State):
	if current_state != new_state:
		print(str(current_state) + " -> " + str(new_state)) # For debugging
		match new_state:
			State.JUMPING:
				# Initialize jump-specific data
				jump_velocity = owner.jump_force # Assuming 'owner' has a 'jump_force' property
		current_state = new_state
