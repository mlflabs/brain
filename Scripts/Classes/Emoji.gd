extends Node3D
class_name Emoji



@onready var sprite:Sprite3D = $Sprite3D
@export var show_time:float = 5

var time:float = 0

enum States  { None, Alert, Anger, Cash, Dot1, Dot2, Dot3, Happy, Sad, 
	Idea, Laugh, Music, Question, Sleep, Star }

var state: States = States.None

func _ready() -> void:
	change_state(States.Alert)

func _physics_process(delta: float) -> void:
	if state == States.None:
		return
	
	time += delta
	if time > show_time:
		change_state(States.None)
		
	

func change_state(s:States):
	if s == state:
		return
	state = s
	time = 0
	match state:
		States.None:
			sprite.visible = false
		States.Alert:
			sprite.texture = load("res://assets/Kenny/Icons/emote_alert.png")
			sprite.visible = true
		
		States.Question:
			sprite.texture = load("res://assets/Kenny/Icons/emote_question.png")
			sprite.visible = true
		States.Sleep:
			sprite.texture = load("res://assets/Kenny/Icons/emote_sleep.png")
			sprite.visible = true
		States.Star:
			sprite.texture = load("res://assets/Kenny/Icons/emote_star.png")
			sprite.visible = true
		States.Happy:
			sprite.texture = load("res://assets/Kenny/Icons/emote_faceHappy.png")
			sprite.visible = true
		States.Sad:
			sprite.texture = load("res://assets/Kenny/Icons/emote_faceSad.png")
			sprite.visible = true
		States.Idea:
			sprite.texture = load("res://assets/Kenny/Icons/emote_idea.png")
			sprite.visible = true
		States.Laugh:
			sprite.texture = load("res://assets/Kenny/Icons/emote_laugh.png")
			sprite.visible = true
		States.Music:
			sprite.texture = load("res://assets/Kenny/Icons/emote_music.png")
			sprite.visible = true
		States.Cash:
			sprite.texture = load("res://assets/Kenny/Icons/emote_cash.png")
			sprite.visible = true
		States.Dot1:
			sprite.texture = load("res://assets/Kenny/Icons/emote_dots1.png")
			sprite.visible = true
		States.Dot2:
			sprite.texture = load("res://assets/Kenny/Icons/emote_dots2.png")
			sprite.visible = true
		States.Dot3:
			sprite.texture = load("res://assets/Kenny/Icons/emote_dots3.png")
			sprite.visible = true
		
			
