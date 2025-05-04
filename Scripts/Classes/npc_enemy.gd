extends Npc
class_name NpcEnemy

@export var stats:NpcStats
#if 0, will be overwritten by stats.life
@export var life:int = 0

@export var waypoint:WayPoint
@export var effect:Effect
 
func damage(value:int):
	change_life(-value)
	effect.start()






func change_life(value:int):
	life += value
	if life < 0: life = 0
	set_life(life)
	print("LIVE changed to: ", life)

func set_life(value:int):
	life = value
	if life <= 0:
		remove()
		return
	BB.blackboard.set(PropertyManager.KEY_PROP_LIFE, life)

func remove_life(value:int):
	change_life(-value)
