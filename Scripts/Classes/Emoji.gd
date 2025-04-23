extends Node3D
class_name Emoji



@onready var sprite:Sprite3D = $Sprite3D
# if its 0, its forever
@export var show_time:float = 5
@export var state:Utils.EmojiStates = Utils.EmojiStates.None

var time:float = 0



func _ready() -> void:
	change_state(state)

func _physics_process(delta: float) -> void:
	if state == Utils.EmojiStates.None:
		return
	if show_time == 0:
		return
	
	time += delta
	if time > show_time:
		change_state(Utils.EmojiStates.None)
		
	

func change_state(s:Utils.EmojiStates, forse:bool = false):
	if s == state and !forse:
		return
	state = s
	time = 0
	match state:
		Utils.EmojiStates.None:
			sprite.visible = false
		Utils.EmojiStates.Alert:
			sprite.texture = load("res://assets/Kenny/Icons/emote_alert.png")
			sprite.visible = true
		Utils.EmojiStates.Cross:
			sprite.texture = load("res://assets/Kenny/Icons/emote_cross.png")
			sprite.visible = true
		Utils.EmojiStates.Question:
			sprite.texture = load("res://assets/Kenny/Icons/emote_question.png")
			sprite.visible = true
		Utils.EmojiStates.Sleep:
			sprite.texture = load("res://assets/Kenny/Icons/emote_sleep.png")
			sprite.visible = true
		Utils.EmojiStates.Star:
			sprite.texture = load("res://assets/Kenny/Icons/emote_star.png")
			sprite.visible = true
		Utils.EmojiStates.Happy:
			sprite.texture = load("res://assets/Kenny/Icons/emote_faceHappy.png")
			sprite.visible = true
		Utils.EmojiStates.Sad:
			sprite.texture = load("res://assets/Kenny/Icons/emote_faceSad.png")
			sprite.visible = true
		Utils.EmojiStates.Idea:
			sprite.texture = load("res://assets/Kenny/Icons/emote_idea.png")
			sprite.visible = true
		Utils.EmojiStates.Laugh:
			sprite.texture = load("res://assets/Kenny/Icons/emote_laugh.png")
			sprite.visible = true
		Utils.EmojiStates.Music:
			sprite.texture = load("res://assets/Kenny/Icons/emote_music.png")
			sprite.visible = true
		Utils.EmojiStates.Cash:
			sprite.texture = load("res://assets/Kenny/Icons/emote_cash.png")
			sprite.visible = true
		Utils.EmojiStates.Dot1:
			sprite.texture = load("res://assets/Kenny/Icons/emote_dots1.png")
			sprite.visible = true
		Utils.EmojiStates.Dot2:
			sprite.texture = load("res://assets/Kenny/Icons/emote_dots2.png")
			sprite.visible = true
		Utils.EmojiStates.Dot3:
			sprite.texture = load("res://assets/Kenny/Icons/emote_dots3.png")
			sprite.visible = true
		
			
