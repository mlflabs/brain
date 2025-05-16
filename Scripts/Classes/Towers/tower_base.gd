extends StaticBody3D
class_name  TowerBase


@export var scanner_area3d: Area3D
@export var data: TowerStage
@export var bb: BrainBoard
@export var bullet:Node3D
@export var ap: AnimationPlayer

var targets: Array[NpcEnemy] = []

var bullet2:Node3D

func _ready() -> void:
	scanner_area3d.body_entered.connect(on_entered)
	scanner_area3d.body_exited.connect(on_exited)

	bb.blackboard.set(PropertyManager.KEY_PROP_ROTATION_SPEED, data.rotation_speed)
	bb.root = $top

func on_entered(body):
	if body is NpcEnemy:
		targets.append(body)
		print("New Target:::: ", targets.size())

func on_exited(body):
	if body is NpcEnemy:
		targets.erase(body)

func cleanup():
	for t in targets:
		if !is_instance_valid(t):
			targets.erase(t)

func start():
	if ap:
		ap.play("fire")
		return
	
	fire()

func fire():
	
	bullet2 = bullet.duplicate()
	
	bullet2.global_position = bullet.global_position
	
	get_tree().current_scene.add_child(bullet2)
	bullet.visible = false
	bullet2.start(bb.target)
