extends CharacterBody3D
class_name Player


@export_category("Stats")
@export var strength:int = 1
@export var calculated_strength:int = 1


@export_category("Player Movement")
@export var speed := 5.0
@export var jump_velocity := 4.5
const ROTATION_SPEED := 6.0

#Player stats


#slowly rotate the charcter to point in the direction of the camera_pivot
@onready var camera_pivot : Node3D = $camera_pivot
@onready var playermodel : Node3D = $playermodel
@onready var action_sensor: ActionSensor = $playermodel/ActionSensor
@onready var player_command:PlayerCommand = $playermodel/Command

enum state {IDLE,RUNNING,JUMPING, TALK, ACTION1, BUSY}
enum action_state { KICK_LEFT, KICK_RIGHT, PUNCH_LEFT, PUNCH_RIGHT }

var attacks: Array[String] = ["attack-kick-left", "attack-kick-right", "attack-melee-left", "attack-melee-right"]

			

var c_state : state = state.IDLE
@onready var animation_player : AnimationPlayer = $"playermodel/character-male-e2/AnimationPlayer"

func _ready() -> void:
	animation_player.connect("animation_finished", animation_finished)

func _physics_process(delta: float) -> void:
	if c_state == state.BUSY:
		if is_on_floor():
			return
			
			
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		#player_animation_state = animation_state.JUMPING
		

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (camera_pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		#now rotate the model
		rotate_model(direction, delta)
		c_state = state.RUNNING
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		c_state = state.IDLE
	
	if not is_on_floor():
		c_state = state.JUMPING
	move_and_slide()
	#tell the playeranimationcontroller about the animation state
	
	if Input.is_action_just_pressed("Action1"):
		c_state = state.ACTION1
	
	if Input.is_action_just_pressed("Action2"):
		player_command.start()
		#c_state = state.TALK
	
	match c_state:
		state.IDLE:
			animation_player.play("idle")
		state.RUNNING:
			animation_player.play("sprint")
		state.JUMPING:
			animation_player.play("jump")
		state.TALK:
			animation_player.play("emote-yes")
			c_state = state.BUSY
		state.ACTION1:
			animation_player.play(attacks[randi_range(0, attacks.size()-1)])
			action_sensor.enable()
			c_state = state.BUSY


func animation_finished(_anim_name:String):
	if c_state == state.BUSY:
		c_state = state.IDLE
		action_sensor.disable()


func rotate_model(direction: Vector3, delta : float) -> void:
	#rotate the model to match the springarm
	playermodel.basis = lerp(playermodel.basis, Basis.looking_at(direction),ROTATION_SPEED * delta)
