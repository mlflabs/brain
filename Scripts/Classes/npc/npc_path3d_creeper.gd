extends PathFollow3D
class_name NpcPathCreeper


@export var npc_stats: NpcStats
@export var npc_anim: NpcAnim
#if 0, will be overwritten by stats.life
@export var life:int = 0
@export var speed:float = 0
var parent:Path3D

var target
var on_destroy_callback

func _ready():
	if life == 0:
		life = npc_stats.life
	if speed == 0:
		speed = npc_stats.speed

func  _physics_process(delta: float) -> void:
	if progress_ratio >= 1:
		remove()
		printerr("finshed path")
	
	progress += delta * speed

func receive_damage(value:int):
	damage(value)

func damage(value:int):
	npc_stats.change_life(-value)

func remove():
	npc_anim.set_state(NpcAnim.State.DIE)
	queue_free()
	on_destroy_callback.call(self)
