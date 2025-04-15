extends Node
class_name NpcAnim





@export var animation_player : AnimationPlayer

enum State {IDLE,RUNNING,JUMPING, DIE, KICK_LEFT, KICK_RIGHT, PUNCH_LEFT, PUNCH_RIGHT}
var current_state : State = State.IDLE
 



func _ready() -> void:
	set_state(State.IDLE)
	


func set_state(s: State, force:bool = false):
	if s == current_state and !force:
		return	
	current_state = s
	if animation_player == null:
		return
	match s:
		State.IDLE:
			animation_player.play("idle")
		State.RUNNING:
			animation_player.play("sprint")
		State.JUMPING:
			animation_player.play("jump")
		State.DIE:
			animation_player.play("die")
		State.KICK_LEFT:
			animation_player.play("attack-kick-left")
		State.KICK_RIGHT:
			animation_player.play("attack-kick-right")
		State.PUNCH_LEFT:
			animation_player.play("attack-melee-left")
		State.PUNCH_RIGHT:
			animation_player.play("attack-melee-right")
			
