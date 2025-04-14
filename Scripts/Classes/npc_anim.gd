extends Node
class_name NpcAnim





@export var animation_player : AnimationPlayer

enum npc_state {IDLE,RUNNING,JUMPING}
var state : npc_state = npc_state.IDLE
 



func _ready() -> void:
	set_state(npc_state.IDLE)
	


func set_state(s: npc_state):
	if s == state:
		return	
	state = s
	if animation_player == null:
		return
	match s:
		npc_state.IDLE:
			animation_player.play("idle")
		npc_state.RUNNING:
			animation_player.play("sprint")
		npc_state.JUMPING:
			animation_player.play("jump")
