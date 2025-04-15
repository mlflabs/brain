extends CharacterBody3D
class_name Npc



@export var BA:BrainAgent
@export var BB:BrainBoard
@export var npc_stats: NpcStats
@export var npc_anim: NpcAnim

var parent

var target

var on_destroy_callback


func interupt(t):
	target = t
	BA.interupt()
	BB.blackboard.set("target", t)
	

func receive_damage(value:int):
	npc_stats.change_life(-value)


func remove():
	npc_anim.set_state(NpcAnim.State.DIE)
	queue_free()

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		on_destroy_callback.call(self)

 
