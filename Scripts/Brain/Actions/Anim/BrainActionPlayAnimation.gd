extends BrainAction
class_name BrainActionPlayAnimation




@export var npc:NpcSmart

@export var animation: NpcAnim.State = NpcAnim.State.IDLE
# 0 just play till end of animation sequence
@export var animation_time: float = 0 


var time:float = 0
enum States {Start, Playing, Finished}
var state:States


func on_enter():
	if animation_time == 0:
		npc.npc_anim.animation_player.connect("animation_finished", animation_finished)
	state = States.Start

func on_exit():
	if animation_time == 0:
		npc.npc_anim.animation_player.disconnect("animation_finished", animation_finished)


func tick(delta:float):
	match state:
		States.Start:
			npc.npc_anim.set_state(animation, true)
			time = 0
			state = States.Playing
		States.Playing:
			if animation_time == 0:
				#no timer needed, just wait for end anim event
				return
			
			time += delta
			if time > animation_time:
				state = States.Finished
		States.Finished:
			return parent.on_result(true)


func animation_finished(_anim_name:String):
	if state != States.Playing:
		return
	if animation_time != 0:
		return
	
	state = States.Finished
