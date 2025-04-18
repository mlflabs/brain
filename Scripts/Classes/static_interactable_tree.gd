extends StaticInteractableItem
class_name  StaticInteractableTree


@export_category("Props")
@export var wood:int = 2
@export var life:int = 4

@export_category("Shake Props")
@export var shake_multiplier: float = 2

var life_lost:int = 0
@onready var mesh = $mesh

func _ready():
	super()
	
	mesh.rotate_y(randf_range(0,180))
	var s = randf_range(0.5, 1.5)
	mesh.scale *= s
	

func damage(value:int):
	life -= value
	life_lost += value
	
	if life < 0:
		ResourceManager.change_wood(wood)
		remove()
		return
		
	interact()
	

func interact():
	if interaction_anim == Interactions.Shake:
		start_shake(shake_intensity + (life_lost * shake_multiplier), shake_speed)
