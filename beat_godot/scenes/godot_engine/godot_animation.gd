extends AnimatedSprite2D
class_name Godot_Animation
@export var scale_animation_redgot : float  = 2
@onready var timer :Timer =$Timer
var _random_string :Array[String] = ["angry","default","default","angry", "terrified","redeyes"]
func _ready() -> void:
    ### timer add timeout
    timer.timeout.connect(random_animation_player)



func random_animation_player():
    if randf_range(0,100) <35:
        play(_random_string.pick_random())
    else:
        play("default")

func play_angry():
   play("angry")

func play_terrifiered():
    play("terrified")

func play_redeye():
    play("redeyes")

func play_red_godot():
    play("redgodot")
    var _tempscale  = scale
    scale *=scale_animation_redgot 
    for x in scale_animation_redgot *5:
        scale = (scale_animation_redgot - x*0.1) * Vector2.ONE
    scale = _tempscale