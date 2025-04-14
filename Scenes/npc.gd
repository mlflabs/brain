extends CharacterBody3D
class_name Npc





@onready var animation_player : AnimationPlayer = $Model/model/AnimationPlayer

######################################
####Seperate this.........
####Make Seperate Anim manager.......

enum npc_state {IDLE,RUNNING,JUMPING}
var state : npc_state = npc_state.IDLE
@onready var playermodel : Node3D = $Model
 



func _ready() -> void:
	set_state(npc_state.IDLE)
	


func set_state(s: npc_state):
	if s == state:
		return	
	state = s
	match s:
		npc_state.IDLE:
			animation_player.play("idle")
		npc_state.RUNNING:
			animation_player.play("sprint")
		npc_state.JUMPING:
			animation_player.play("jump")
