extends BrainAction
class_name BrainActionPlayAnimationSequence




@export var bb:BrainBoardNpc

@export var anims:Array[AnimationSequenceItem] = []

var index:int = 0
var time:float = 0
enum state {Start, Playing, Finished}
var current_state:state 
var current_animation:AnimationSequenceItem

func on_enter():
	bb.npc_anim.animation_player.connect("animation_finished", animation_finished)
	
	index = 0
	current_state = state.Start
	if anims.is_empty():
		printerr("No animations specified")


func on_exit():
	bb.npc_anim.animation_player.disconnect("animation_finished", animation_finished)


func tick(delta:float):
	match current_state:
		state.Start:
			if index == anims.size():
				return parent.on_result(true)
			current_animation = anims[index]
			bb.npc_anim.set_state(current_animation.state)
			time = 0
			current_state = state.Playing
		state.Playing:
			if current_animation.time == 0:
				#no timer needed, just wait for end anim event
				return
			
			time += delta
			if time > current_animation.time:
				current_state = state.Finished
		state.Finished:
			index += 1
			current_state = state.Start


func animation_finished(_anim_name:String):
	if current_state != state.Playing:
		return
	if current_animation.time != 0:
		return
	
	current_state = state.Finished
