extends AnimatedSprite2D
class_name Godot_Animation

@onready var timer :Timer =$Timer
var random_string :Array[String] = ["angry", "terrified","redeyes","redgodot"]
func _ready() -> void:
    ### timer add timeout
    timer.timeout.connect(random_animation_player)



func random_animation_player():
    if randf_range(0,100) <35:
        play(random_string.pick_random())
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