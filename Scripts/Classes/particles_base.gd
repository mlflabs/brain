extends Node3D
class_name particles_base

@export var particles:Array[GPUParticles3D]


func start():
	for p in particles:
		p.emitting = true
