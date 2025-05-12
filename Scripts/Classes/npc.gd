extends CharacterBody3D
class_name Npc



@export var BA:BrainAgent
@export var BB:BrainBoard
@export var npc_stats: NpcStats
@export var npc_anim: NpcAnim
#if 0, will be overwritten by stats.life
@export var life:int = 0
var parent
var target
var on_destroy_callback

func _ready():
	if life == 0:
		life = npc_stats.life


func interupt(t):
	if t == self:
		target = null
		BB.blackboard.set(PropertyManager.KEY_TARGET, null)
		BA.interupt()
	target = t
	BA.interupt()
	BB.blackboard.set(PropertyManager.KEY_TARGET, t)

func loose_target(t):
	if target == t:
		BB.blackboard.set(PropertyManager.KEY_TARGET, null)
		BA.interupt()

func receive_damage(value:int):
	damage(value)

func damage(value:int):
	npc_stats.change_life(-value)

func remove():
	npc_anim.set_state(NpcAnim.State.DIE)
	queue_free()

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		on_destroy_callback.call(self)

 
