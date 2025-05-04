extends Node3D
class_name  SingleEvent_Bus


signal on_event_signal()

func on_event():
	on_event_signal.emit()
	
